Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CB3097DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 20:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhA3TO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 14:14:26 -0500
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:40152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230045AbhA3TO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 14:14:26 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 14:14:26 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 8916618014C95
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Jan 2021 19:04:44 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E4803180A7FF9;
        Sat, 30 Jan 2021 19:04:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3868:4321:5007:7652:8603:10004:10400:10848:11026:11232:11658:11914:12296:12297:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: low08_4a03ddb275b3
X-Filterd-Recvd-Size: 2416
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 19:04:01 +0000 (UTC)
Message-ID: <15ab6a821b32d6fd4b49ee2037dc85e4ba6b08cc.camel@perches.com>
Subject: Re: [PATCH 23/29] fuse: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 11:04:00 -0800
In-Reply-To: <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <1ccd477e845fe5a114960c6088612945e1a22f23.1598331149.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?
 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  fs/fuse/dir.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 26f028bc760b..ecb6eed832a0 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1362,14 +1362,22 @@ static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
>  {
>  	unsigned ivalid = iattr->ia_valid;
>  
> 
> -	if (ivalid & ATTR_MODE)
> -		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
> -	if (ivalid & ATTR_UID)
> -		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
> -	if (ivalid & ATTR_GID)
> -		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
> -	if (ivalid & ATTR_SIZE)
> -		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
> +	if (ivalid & ATTR_MODE) {
> +		arg->valid |= FATTR_MODE;
> +		arg->mode = iattr->ia_mode;
> +	}
> +	if (ivalid & ATTR_UID) {
> +		arg->valid |= FATTR_UID;
> +		arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
> +	}
> +	if (ivalid & ATTR_GID) {
> +		arg->valid |= FATTR_GID;
> +		arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
> +	}
> +	if (ivalid & ATTR_SIZE) {
> +		arg->valid |= FATTR_SIZE;
> +		arg->size = iattr->ia_size;
> +	}
>  	if (ivalid & ATTR_ATIME) {
>  		arg->valid |= FATTR_ATIME;
>  		arg->atime = iattr->ia_atime.tv_sec;


