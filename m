Return-Path: <linux-fsdevel+bounces-42070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C45FA3BFE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3011D16BD57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7391EA7C2;
	Wed, 19 Feb 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R61Ut1vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DD1E51F8;
	Wed, 19 Feb 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971554; cv=none; b=kWwDRh4kGz1HOl2X4OZDv+hUItSfe3LybHL6fcZkg88l0qtasZLc7+mYN1xYtQcJ4yahqR4uCvgwTrzc54znW0TJvcWrvfX9oJvqfB4taTRiWc95F5cpQOsaON2XJj+LGl1ZREbYSjz3z5DbHoi9uwR/zWquxAC3HIFzLlot2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971554; c=relaxed/simple;
	bh=bUUxrCgaVkCHk277fuWnBwwOiDkKCAbDTbxocF6uyrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klGHxujvj1rS92Ibbey8XzK2mhfXIgZ6pW4pQ2hkAKB1WNVLswT7UXnXzrn0kZDBZvnatpVLm9Qu6tC5iM/aqjV/KSacBxvOu2EYtW+AKzep/LTdYLKuA58clmmZVH/+xFt2V4NHzkUv3TG5w62HCY2FYYgqxGFlrV4sSIRCO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R61Ut1vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D57CC4CED1;
	Wed, 19 Feb 2025 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739971554;
	bh=bUUxrCgaVkCHk277fuWnBwwOiDkKCAbDTbxocF6uyrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R61Ut1vZNEpE9REYkvh1ResJL2vIknAPOCMnNF9Mkc59MshNHQox7mG6t/UjCRT8Q
	 1jS2Ra8jHBrKNsfne6Sm6ugFnyB5PWLMamzHd/WJ5HNcZorxYCIck/tIuhMuT8a2ef
	 93W2naBIk0J4wOzbSLtZE1gS3iJhOMuURXSbG1T5yayraBZIIc981JV/7i9Z5UJ98E
	 qoL82bf72Hjmm7VtvG/kJVwvsAWsw9UtPOKx+yr4vaP4Oy0pszyTX0MYGsNIDWurTs
	 N0//2RHKA135thH76MbDEQSEQZqv6B0E6PCNHyIW3wSJQ1GqLSeX6njlycHXcutNlM
	 usiBCTk3iwwng==
Date: Wed, 19 Feb 2025 14:25:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] selftests/ovl: add second selftest for
 "override_creds"
Message-ID: <20250219-raumluft-ritualisieren-50f232bc0d61@brauner>
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org>
 <20250219-work-overlayfs-v3-3-46af55e4ceda@kernel.org>
 <CAOQ4uxhmzcQxB+udEwsLjJVxqtof_Py9Ctn41=q6Xvi1PaaA6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhmzcQxB+udEwsLjJVxqtof_Py9Ctn41=q6Xvi1PaaA6A@mail.gmail.com>

On Wed, Feb 19, 2025 at 01:36:17PM +0100, Amir Goldstein wrote:
> On Wed, Feb 19, 2025 at 11:02 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Add a simple test to verify that the new "override_creds" option works.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> For the added test you may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> But you may want to consider splitting the large infrastructure
> and the churn to the previous test to a separate patch, to make this
> patch cleaner.

Done.

