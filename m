Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC017E87E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 20:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgCITbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 15:31:51 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:48014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgCITbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:31:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D9FB01025604F;
        Mon,  9 Mar 2020 19:31:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3867:3872:4321:4362:5007:8603:10004:10400:10848:11026:11232:11658:11914:12048:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14254:14659:14721:21080:21451:21627:21990:30001:30002:30003:30004:30005:30006:30007:30008:30009:30010:30011:30012:30013:30014:30015:30016:30017:30018:30019:30020:30021:30022:30023:30024:30025:30026:30027:30028:30029:30030:30031:30032:30033:30034:30035:30036:30037:30038:30039:30040:30041:30042:30043:30044:30045:30046:30047:30048:30049:30050:30051:30052:30053:30054:30055:30057:30058:30059:30060:30061:30062:30063:30064:30065:30066:30067:30068:30069:30070:30071:30072:30073:30074:30075:30076:30077:30078:30079:30080:30081:30082:30083:30084:30085:30086:30087:30088:30089:30090:30091,0,RBL:none,Cac
X-HE-Tag: desk11_2ce8ed604532a
X-Filterd-Recvd-Size: 1434
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 19:31:48 +0000 (UTC)
Message-ID: <19abedb11fae1b96aa052090e7a0d5bbea416824.camel@perches.com>
Subject: Re: [PATCH] xattr: NULL initialize name in simple_xattr_alloc
From:   Joe Perches <joe@perches.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Date:   Mon, 09 Mar 2020 12:30:07 -0700
In-Reply-To: <20200309183719.3451-1-dxu@dxuuu.xyz>
References: <20200309183719.3451-1-dxu@dxuuu.xyz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-03-09 at 11:37 -0700, Daniel Xu wrote:
> It's preferable to initialize structs to a deterministic state.

Thanks Daniel.

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  fs/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..92b324c265d2 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -821,6 +821,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	if (!new_xattr)
>  		return NULL;
>  
> +	new_xattr->name = NULL;
>  	new_xattr->size = size;
>  	memcpy(new_xattr->value, value, size);
>  	return new_xattr;

