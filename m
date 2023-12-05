Return-Path: <linux-fsdevel+bounces-4866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F36D8054CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17A9B210C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235995C8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YinYHhv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A110940
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 11:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16B5C433C7;
	Tue,  5 Dec 2023 11:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701774397;
	bh=rgJUwJ6GqxS/UtDw9jRVOllmpQab2HhQKk5CRvGD4NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YinYHhv+6oqy4AS4LYHcW4XAfudoECQpbKl8DmASdgq7tjk5FAu1qSLGG7EPgC8yg
	 +HghCWl5DtDIrJJSKwUxlMtc5+WbeHNQDIy8IB1ZdP2qt+0+m3/I/4gdKkpL2cMoh7
	 XbNlAAUv7/AiKeT+8XCRUo0taWr6T7dLzcpH/151gKrKFClEz3MZt93xsBbTkKxNNz
	 ofUqL+FbylkjHC2s15WxU3ojQ5tHSjhPyEW5QfIV6jHlkYU9erT66RZ0GzJeTGaFBq
	 Qbt7pvb7vzdUMdQxE2nmyokY6HQtvEjiJA0hpzSEwD1uhAyzQCrFVGw2H1Pb75znqO
	 VPgRxmUdYHeVA==
Date: Tue, 5 Dec 2023 12:06:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hao Ge <gehao@kylinos.cn>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, gehao618@163.com
Subject: Re: [PATCH] fs/namei: Don't update atime when some errors occur in
 get_link
Message-ID: <20231205-endstadium-teich-d8d0bc900e08@brauner>
References: <20231205071733.334474-1-gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205071733.334474-1-gehao@kylinos.cn>

On Tue, Dec 05, 2023 at 03:17:33PM +0800, Hao Ge wrote:
> Perhaps we have some errors occur(like security),then we don't update
> atime,because we didn't actually access it
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---

We didn't follow the link but we accessed it. I guess it's not completey
clear what's correct here so I'd just leave it as is.

