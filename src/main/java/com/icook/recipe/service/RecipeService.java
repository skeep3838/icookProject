package com.icook.recipe.service;

import java.util.List;

import com.icook.model.MemberBean;
import com.icook.model.RecipeBean;

public interface RecipeService {
	List<RecipeBean> getAllRecipes();
	List<RecipeBean> getRecipesByMember(int userId);
	List<RecipeBean> getTop3RecipesByPV();
	public RecipeBean getRecipeByRecipeNo(int recipeNo);
	
	void addRecipe(RecipeBean recipe);
	void updateRecipe(RecipeBean recipe);
	void deleteRecipe(int recipeNo);
	public MemberBean getMemberId(int userId);
	
	void updatePageView(int recipeNo, int pageView);
}
