Return-Path: <linux-fsdevel+bounces-37074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E09ED20D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D159A282604
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7391DDC09;
	Wed, 11 Dec 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSoWiScB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0119FA93
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934871; cv=none; b=sEDQiBBYKqCiM0lkWsuLPiF1kVKbx0GT1ZvBXoTW/Gx44CA4GuKSzqLzPBxurW2KIyKUYiHcScAyi8FS00AUdzSxXFg6wgtI9VLOvDTT/XVKPdqIy4+OlMMLNiz2oWngJkT+MNChEoaGIZGkcmzMN11R4Vg6YvHx4qdWrLwIqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934871; c=relaxed/simple;
	bh=yBxhaTjfOizIhOczBCvRSt8i8RfB5LwMMeLFbd3UysI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAdNKhQNzU0jJwPoQ2EO0cy2zmG7IxaYaEhV0P//UjrXUJpYnkqbddlcPO/QCt8Yk+rs1Obt2gMzoRcWJYu7z6zC9bi3+skNiLV3TQjB+yhEgm1c8LQerX2QNzNuw+kTLYpCuEt6pk4i5ZaDZa+h0xBMteYKC82woqOBUmSuxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSoWiScB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F0C4CEDE;
	Wed, 11 Dec 2024 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934870;
	bh=yBxhaTjfOizIhOczBCvRSt8i8RfB5LwMMeLFbd3UysI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSoWiScBUlCsToFXFuXL3LSMYazRBp+tcfmfCWJIPJnP+olYjZ+rDyEkpIaLt23H7
	 4mYaySe1iZi556hXu8HlOGHFrYyBjC7kd2zNhfHaUbrf1gENqsbYq1ro540e7zuFxi
	 Qdp50omglB60PKm3EYgakvDLOFLBpJejzfPqrX3ORDVjN9KtoCuWIbyhMUAxzCiDX+
	 ncbuUpqqA8+fnXv3KJZYQyw1WB9zguyxy2XNRfcNKvyGXRABqeuaYNp0KFjXPwoIDI
	 ctIAd5lgyGOyTW4WzgUJrtjTYAIlxuDlRUt5ZgDNpPutYnH8CY44/Vn3RLvITuQCIX
	 L8V/Mad8zzQEA==
Date: Wed, 11 Dec 2024 17:34:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] samples: add test-list-all-mounts
Message-ID: <20241211-angekauft-abluft-12f84e6db731@brauner>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
 <20241210-work-mount-rbtree-lockless-v1-5-338366b9bbe4@kernel.org>
 <50ea8aea7eff7ec8680564c10c54f6d1e4dee20b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50ea8aea7eff7ec8680564c10c54f6d1e4dee20b.camel@kernel.org>

> Note that this replicates a lot of the functionality of the "mountinfo"
> program. You could also extend that program with a different output
> format instead of adding a new one.

Fair. I'll see what I can do.

