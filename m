Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC27103BF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 14:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfKTNi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 08:38:58 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:59967 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfKTNi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:56 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 08:38:55 EST
X-EEMSG-check-017: 32484972|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,222,1571702400"; 
   d="scan'208";a="32484972"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Nov 2019 13:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574256700; x=1605792700;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=C/ZFwtvRVxaXzV0I3q2SFN5eIsnXw3FwCEkb+yT+SVE=;
  b=m1ZiqV+oKU+VETLFHWiLZqsZYeF/IYJdamI/G1LZuGPWAIKAK2rR8+dt
   s8VASEggUjSFE8D7hiQS8NcJc0ew++hA7FGU3lWuIqRXLj6nQ1qevuVJy
   /JFeSQAr4LpRBMuvcRLhVDyjgfCX+bwf2xKv437K2lKawjgPccTbqrxxJ
   MLQ549Fv6/kkhMi9WstOaFKxTFt9yQgXKWzzGiSFSDZqX3bC6xPIf4/mI
   DdIN+PpLUvQyZ5L9b/kZjSZp/tQ/8fAtcTO4aBWjW+JtXffMmrA99zH/U
   PuZcXQjaKwRjytE9veY8JJ0wRj8vkfFfwXgbNNHbu0EIvspUACA0Q+fOa
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,222,1571702400"; 
   d="scan'208";a="30306507"
IronPort-PHdr: =?us-ascii?q?9a23=3A4/COgB9P38K04v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0usSIJqq85mqBkHD//Il1AaPAdyArasZ06GK4ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRWqoQneucQbhZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4T9o1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumarHK58u3r4wlp?=
 =?us-ascii?q?0JvUTFAiD2g1n5gLWTdkUl/uik8+XnYrP4qZ+AL4J4lw7zP6s0lsG/HOg0KB?=
 =?us-ascii?q?YCUmeF9eimybHv5Uj5T69Ljv0ynKnZqpfaJcEDq66iHgBVyZ0u6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFReeB2dlYTpNFbOIO7gAfeln1usiCtrx+zBPrD5DJTNL3zDkLP6cL?=
 =?us-ascii?q?Z+9UFc0gwzws5b555ODbEBOv3zUFfrtNPEFh85LxC0w+H/BdVmyIweXWOPAq?=
 =?us-ascii?q?mEMKLdqlKI+O0vLPeWZIMPuzbyNeIl5/jwgn89g1MderOp3ZQPYnCiAvtmO1?=
 =?us-ascii?q?mZYWbrgtoZFWcKvww+TPHliVGbUj5ceWyyX6Qi6TE/E4+mE4jDSZ63gLCb3y?=
 =?us-ascii?q?e0AIdWZmZYBVCIC3vocJ+EW/gUYiKIPsBhiiAEVaSmS4I5yxGutRX6y718I+?=
 =?us-ascii?q?vV5CIYs5Pj1MZv6+3XlBEy8yF0DsuH32GKVWF0kXkERyI13Kpnu0xy1k+D0b?=
 =?us-ascii?q?Rkg/xfDdFT4/JJUgEnNZ/T1uB6BcvyVR/fcdeXVlmmRs6rAS8+Tt0v2d8CeU?=
 =?us-ascii?q?V9FMu4jhDFwSWqB6UZl7uRBJw76qjcxWT+J95hy3ba06ksl0cpQtNVOm28h6?=
 =?us-ascii?q?5/7BPeB5bTnEWDlqaqbrwc3CrX+2if02WCpkZYUBR/UfaNYXdKWUrSqZzV60?=
 =?us-ascii?q?rJSLnmXasmNg9pysOYLKZOLNrzggMVau3kPYHlf2+pm2q2TS2Nz7eIYZuiL3?=
 =?us-ascii?q?4Rxw3BGUMElEYV5n/AOg8gUHTy61nCBSBjQAq8K3jn9vNz/TbiEx45?=
X-IPAS-Result: =?us-ascii?q?A2A5AADFPtVd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdCyBc4RUj1YGgREliWaKH4ckCQEBAQEBAQEBATQBA?=
 =?us-ascii?q?gEBhEACgickOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgm0BBSMEEUEQCxgCA?=
 =?us-ascii?q?iYCAlcGDQgBAYJfP4JTJbBMfzOFToM5gUiBDiiMFRh4gQeBEScMgl8+h1WCX?=
 =?us-ascii?q?gSNAoh7YUaWHG6CNYI3kxIGG4I+h2mDKYERizMtqjgigVgrCAIYCCEPgyhPE?=
 =?us-ascii?q?RSGfm8BCI00IwOBNQEBji4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Nov 2019 13:31:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAKDVasW030479;
        Wed, 20 Nov 2019 08:31:37 -0500
Subject: Re: [RFC PATCH 2/2] selinux: Propagate RCU walk status from
 'security_inode_follow_link()'
To:     Will Deacon <will@kernel.org>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        linuxfs <linux-fsdevel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-3-will@kernel.org>
 <d1b03e3f-2906-d022-3578-e443a5ebb1a0@tycho.nsa.gov>
 <20191120131303.GB21500@willie-the-truck>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a9c90e27-2281-60aa-c835-d4b9a5460f39@tycho.nsa.gov>
Date:   Wed, 20 Nov 2019 08:31:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120131303.GB21500@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/19 8:13 AM, Will Deacon wrote:
> Hi Stephen,
> 
> Thanks for the quick review.
> 
> On Tue, Nov 19, 2019 at 01:46:37PM -0500, Stephen Smalley wrote:
>> On 11/19/19 1:40 PM, Will Deacon wrote:
>>> 'selinux_inode_follow_link()' can be called as part of an RCU path walk,
>>> and is passed a 'bool rcu' parameter to indicate whether or not it is
>>> being called from within an RCU read-side critical section.
>>>
>>> Unfortunately, this knowledge is not propagated further and, instead,
>>> 'avc_has_perm()' unconditionally passes a flags argument of '0' to both
>>> 'avc_has_perm_noaudit()' and 'avc_audit()' which may block.
>>>
>>> Introduce 'avc_has_perm_flags()' which can be used safely from within an
>>> RCU read-side critical section.
>>
>> Please see e46e01eebbbcf2ff6d28ee7cae9f117e9d1572c8 ("selinux: stop passing
>> MAY_NOT_BLOCK to the AVC upon follow_link").
> 
> Ha, not sure how I missed that -- my patch is almost a direct revert,
> including the name 'avs_has_perm_flags()'! My only concern is that the
> commit message for e46e01eebbbc asserts that the only use of MAY_NOT_BLOCK
> is in slow_avc_audit(), but AVC_NONBLOCKING is used more widely than that.
> 
> For example:
> 
> 	selinux_inode_follow_link()
> 	  -> avc_has_perm()
> 	    -> avc_has_perm_noaudit()
> 	      -> avc_denied()
> 	        -> avc_update_node()
> 
> where we return early if AVC_NONBLOCKING is set, except flags are always
> zero on this path.

That was introduced by 3a28cff3bd4bf43f02be0c4e7933aebf3dc8197e 
("selinux: avoid silent denials in permissive mode under RCU walk") and 
is only needed if we have to pass MAY_NOT_BLOCK to slow_avc_audit(), 
which is only presently needed in the selinux_inode_permission() case 
AFAICT.  Both AVC_NONBLOCKING and MAY_NOT_BLOCK are misnomers wrt the 
AVC since it should never block regardless; the issue IIUC was rather 
the inability to safely collect the dentry name in an audit message 
during RCU walk per commit 0dc1ba24f7fff659725eecbba2c9ad679a0954cd (" 
SELINUX: Make selinux cache VFS RCU walks safe").

I'm not 100% certain about this; it is possible that the test in 
slow_avc_audit() is wrong and we ought to be doing this for any of 
LSM_AUDIT_DATA_PATH, _DENTRY, or _INODE (these were split out of 
LSM_AUDIT_DATA_FS).  In that case, we should revert my earlier commit 
for follow_link and fix the test inside of slow_avc_audit() instead.

I cc'd some additional folks who may have insight.  Al, tell us if we 
got it wrong please!
