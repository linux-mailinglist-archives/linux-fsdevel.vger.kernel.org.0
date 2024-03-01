Return-Path: <linux-fsdevel+bounces-13294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFE86E3C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061BB1F2607C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80AF3AC01;
	Fri,  1 Mar 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="CvzNoJPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A920E3;
	Fri,  1 Mar 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304888; cv=none; b=q+yjFz8ivGJfFz+0h+M4Ze3Xm530WK/g4zsESjKwOOJsO7IDW8gYbG2ndXGDMx6opHBsDB2tZBkhXUrGJKUnLeHqISyzC08JId1omr1FXX+Q33r7LposWgvrbcsnhuw9bhcA3Rhmt0eeiR4xcmrYupOu2QFWa3A+M9SQfjZ5HZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304888; c=relaxed/simple;
	bh=X8fFdJoaSKFmUqv9TVvd9Ec/JjJVeyfcUOCyiD6qiKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ukh7MvQePr87WpU5QvzJW/P02UeIaTcCAzFUxUOzey/SOslnDAfQ5zq31v+SpNzWp1T87zK9qPBluzZIXwGv4PwDdTR7ZaRY9K/i8/sXa2Kacr46im61WyotBmukhXEQENAGjde6vFDBt9JUxG/HhFCu+zFVLN+KlgQRs9fqoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=CvzNoJPc; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 735E34872F0;
	Fri,  1 Mar 2024 08:54:38 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 735E34872F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1709304878;
	bh=1ZrvFehOaznTFgXD3lcw32aClQmOZtUviT4RwAf+m2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CvzNoJPc18VIVb5H+r7gZptWtnzscNvOst0ZNrM7af0rwmpbKFGUNSBiDIM9xDM7Q
	 Crf3c7a/82nYJwBeK4oHzHZkxuopATozEff1bsjq8UZVq+UFAKDdJtgT3/u66GJkwx
	 F2LmPj0Gl9n891fi8NgJxPdwmgcXeabskl7tQZslci3U4aShDp1Xdl6YplxJp28zmx
	 Uz8qgDrKoKJLHyDNwhXfI0PfS5Fnj8CootYRasuy36D8NdrOzTjgTojW+tLlZsERPt
	 3dmX6LxHtSe48++ws3Xfcr6tA5WEHp6d5ci1iSu4hSMxpnHzmXDj5eFKmZxzNr5Ct2
	 q8wgP9PNlXT4A==
Message-ID: <8127e57f-51e8-437d-bf84-4836a315f696@sandeen.net>
Date: Fri, 1 Mar 2024 08:54:37 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fs_parser: handle parameters that can be empty and
 don't have a value
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Luis Henriques <lhenriques@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240301-abheben-laborversuch-1a2c74c28643@brauner>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20240301-abheben-laborversuch-1a2c74c28643@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/24 7:12 AM, Christian Brauner wrote:
>> Unfortunately, the two filesystems that use this flag (ext4 and overlayfs)
>> aren't prepared to have the parameter value set to NULL.  Patches #2 and #3
>> fix this.
> 
> Both ext4 and overlayfs define
> 
> #define fsparam_string_empty(NAME, OPT) \
>         __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
> 
> Please add that to include/linux/fs_parser.h so that it can be used by both.

The f2fs conversion will also need this, so yes, it'd be nice to hoist it out
of ext4 and overlayfs.

-Eric


