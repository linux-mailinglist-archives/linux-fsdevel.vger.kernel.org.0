Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B022F242F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLT0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:26:43 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:47300 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLT0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:26:42 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 15:26:41 EDT
X-EEMSG-check-017: 140741912|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.76,305,1592870400"; 
   d="scan'208";a="140741912"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Aug 2020 19:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1597259905; x=1628795905;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CueohJZx1/qXKuWloOiESfHo96sdfx+fXREsHuVp6DU=;
  b=Q8PEiWbTufiwiNjVk3ypPUOeKBSoChGPRPVtK9kXkdscE7d0F7LqRPeE
   U6iGNlimTAv/T3BAAfoZlFGxNoqvyEGr0PATJllYANlATrPjxLHjXu21h
   fPoAFhNxmUcaS8lKdXgx8K2AgV6JDm+oXifZJ+9UpQJdlZgXZJECeIw5c
   R5BVFr29DtRmfx2Usc9iVesm9CZg4wOcFm3CybQ1VLmTO/R6SuZJI5kEy
   kl14+y0jBm+yO1rfeFckZ2xicGDhKLJEuGUp7KdTnXE8vNuJmOpkYdfyH
   W7PrV9zmXHy68nXzeBkY7S35GtK4LINM0hr15jjEL/bBrZ6tFr1PfI870
   A==;
X-IronPort-AV: E=Sophos;i="5.76,305,1592870400"; 
   d="scan'208";a="39350079"
IronPort-PHdr: =?us-ascii?q?9a23=3ARwX+ER+z4+2mmv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B91+0fIJqq85mqBkHD//Il1AaPAdyFraMewLON7+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVhTexe7d/IAu5oQnMuMQbjpZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4XjqVYCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOOvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIR5Xs0sWXtnuDomyrIYo5?=
 =?us-ascii?q?67ejAHxYkoyhPcb/GJc4aG7xL/WeuMITl1gHNodbKhihi88UWs1u3xW8e23V?=
 =?us-ascii?q?pUsydLncfAu24O2hHO9sWLV+dx81mh1DuJygvd5OZEIUUumqraLZ4s2r0wmY?=
 =?us-ascii?q?QJsUTFACD2nF/6jKiMdkUr/OWj9ufpYq3+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9em6ybbt51f2QK9Qgf0ziqTZtZfaKtkFqaOhGA9V15oj6w64Dze7zN?=
 =?us-ascii?q?QUhXkHI0xBeBKAl4XpJ0vBIOr5DfeimFSgiitrxvDaMb3hBZXBNH7Dn6v6fb?=
 =?us-ascii?q?lh8UJczQszzdRH65JVDLEOPu7zV1fsuNHXARI1KQy5z/v9BNlj2Y4SR3iDDr?=
 =?us-ascii?q?KBPKPXq1CI5+YvI+eWZI8SvTbwM+Ml6OP1jXIihV8cfbWm3ZsQaHyiGPRmOF?=
 =?us-ascii?q?+WbWDjgtcGD2cGphA+Q/DyiF2eTT5TYG6/X6c95j4nE4+pEIbDRo+sgLyC2y?=
 =?us-ascii?q?e0A4daZmZYBVCQCX3obZmLW+8QaCKOJc9sijgEVbmnS4882hCirQz6xKR9Lu?=
 =?us-ascii?q?rS5CIYsYnu1MZ65+LNjxE+7z90ANqH02GLUW50mnkERzgs3KBwuUZ90EuM0b?=
 =?us-ascii?q?Bkg/xEEtxe/+1JUgYgNZ7b1OF7Cs79WgTAfteXUlqmRtSmATcsTtM+2dMOZF?=
 =?us-ascii?q?x9G9q4ghDe3CqgG6UVmKCTBJwo7qLc2GD8J8Jgy3ba06kslEMpQs5VOmK6nK?=
 =?us-ascii?q?F/7wnTB5LTnEWdjaqqc7oT3DLV/meZ0WWOpF1YUBJ3UajdR38fYFfWrdP/5k?=
 =?us-ascii?q?/YTr+uF64oMg1Gyc6cMaZFdsfmjVBdS/f5OdTRfm2xlHm/BRaS2LyNbJHqd3?=
 =?us-ascii?q?8B0yXaDUgOixoT8mqeNQgiGiehpHrTAyZ0FVLpfkzh6vNxqGm9TkAp1A6GdV?=
 =?us-ascii?q?Bu2KSt8B4PmfOcU+8T3q4DuCo5tzp7Bk290MzWCtebvApuYKVcbskg4FdJ0W?=
 =?us-ascii?q?LWqRZ9MoW8IK94nFIRbwN3v0b23RVtFopAidQqrG8tzAdqK6KY1VRBdymC3Z?=
 =?us-ascii?q?DxIb3aMW/y8wqqa6HI21HSytGW+r0A6P4gsVXsoBmpFlY+83Vgy9RV0WGT5p?=
 =?us-ascii?q?PMDAoSSp/xXUE39x91p7HefCYx/Z/b1XppMaOsqD/Nx8opBPc5yhanZ9pfMr?=
 =?us-ascii?q?6LFA7xE8IEHMWhMvEllEW1bhIDPeBS6LQ4MN+hd/uDwKSrJvpvnCq6jWRb54?=
 =?us-ascii?q?Bwyl6D9y1mSuHTwZkF3+qV3g+JVjf6lluhtN74mZxcbzEIAmW/0TTkBJJWZq?=
 =?us-ascii?q?BqfoYEF3mhI9arydV5gJ7tWGVV+0KjB1Mc38+pfBuSb0H43QFK0kQXu3Onkz?=
 =?us-ascii?q?OizzNoizEpsraf3CvWzuTnaBoHOXRHRGx4glfqOYi7ld8aU1azbwUymxul4F?=
 =?us-ascii?q?z1x6lfpKhlM2bTRkJIdTDsL25+SquwqqaCY8lX5ZMysCVYTOS8bkqASrHguB?=
 =?us-ascii?q?Ya1STjEHZEyD8hazGgoo/5kABiiGKBMHZzq2LUedpuyhfF69zTW+Vc3jocSy?=
 =?us-ascii?q?l8jTnWBl68M8O18tWTkpfJqvq+WH65Vp1PbSnrypuNtDC75W13GxK/n+u+mt?=
 =?us-ascii?q?75Hggg1y/0yd1qWT/PrBbmbYnhz766Pv5/fkl0GF/87NJ3Gp9/kos2mJ4fx3?=
 =?us-ascii?q?4ahomP8XUai2jzPtJb2aT4bHUTXzEL3sXY4BP+2E1iNH6JyIX5VmiDwsd7ad?=
 =?us-ascii?q?m6eHsc2jgh4MBSFKeU8LtEkDN2olWmtwLRZ+ZynjMExfsu8nEamfwGtxQrzi?=
 =?us-ascii?q?WcBLASElJVPSjtlxST89C+t79bZGG3cbeu0kp/k8quDLWGog1GRHn5fZIiFz?=
 =?us-ascii?q?dq7spjKFLMzGHz6ob8ddnUbNITsACUkhjZg+dPMJIxl+EHhTRoOW3jp30p0e?=
 =?us-ascii?q?07ggJ03ZG8ooeHL39h/KWjAh5XLjf1fd8c+inxjaZCmcabx4SvHpRnGjUWU5?=
 =?us-ascii?q?rkVOinECgOuvTnLAuODjI8pWmBGbbFHg+Q9l1mr3TRHJCvLX2XI2MZzdp6Th?=
 =?us-ascii?q?mHOENfmBwUXCk9npMhEgCqxcrhcFp25zwI+1H4rQdDx/l2NxnwTGjfvh2kaj?=
 =?us-ascii?q?QqR5iFKhpZ8AVC613SMcyE4eJ5BztY8YG5rAyRNmybYBxFDWUIWkyCGlDiMa?=
 =?us-ascii?q?Ci5dfb8+eFGOW+MeXBYbGVpOxAWPeH24iv3pFl/zmSLMWPOGdtD/kh1kpER3?=
 =?us-ascii?q?B5FNzTmy8TRCwPiyLNc8mbqQ+4+i12qMC/7fvqVBvs5YuUFbRSNdtv+wyojq?=
 =?us-ascii?q?eYK+6dnzh5KTlG2ZMW33PIy6YQ3EQUiy5wczmhC7MAtTTCTKjIgK9YEwYbaz?=
 =?us-ascii?q?9vNMtP96882ghNOcjGitL6z7J4leA6BEtYVVz7m8GpecwLL3i4NFPAGUmLKb?=
 =?us-ascii?q?CGKiPQzsHpbqOzV6dQgP9XtxKuozabFVHsPjCZmznuTRCvPvlGjDuHMxxGpI?=
 =?us-ascii?q?G9bhFtBHDsTd/laxC2K9x3giMswb0ymHzKMXQQMT9mc0NCtreQ9z9Xgu1jG2?=
 =?us-ascii?q?xd6XpoNeuEmyGZ7+neMJoWs/xrAiRumOJc+3Q11b1V4TpYS/NvnivSqdhuo1?=
 =?us-ascii?q?C6neaVzjprSgZBqjFOhNHDgUI3HKTS9ZDDXUH/9RYEeWPYXxELrPNpC9LuuK?=
 =?us-ascii?q?dcjN7CiPS3YDND9c/EuMgRHc7ZLOqZP3c7dxnkAjjZCE0CVzH4G3vYghlmjP?=
 =?us-ascii?q?yK9nCT5qM/o5zolYtGHqRXT3QpB/gaDQJjB9VEL5BpCGB32YWHhdIFsCLt5C?=
 =?us-ascii?q?LaQ99X69WeDKmf?=
X-IPAS-Result: =?us-ascii?q?A2A4AADZPzRf/wHyM5BfGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUqBe4EeVAFehDaPYQaBN4oWkXsLAQEBAQEBAQEBK?=
 =?us-ascii?q?wkBAgQBAYRMAoI2AiQ4EwIQAQEBBQEBAQEBBgMBAYZIDII3KQGDEAEBAQEDI?=
 =?us-ascii?q?wQLAQVBEAsVAwICJgICVwYBDAYCAQGCYz8BglclD7FNdn8zhDsBgRaDP4E6B?=
 =?us-ascii?q?oEOKgGNDxp5gQeBOA+CWj6BF4Y9gmAEkj4Bo2mCbIMLhViRKgUHAx6gFZIvi?=
 =?us-ascii?q?j2XCYF6KwgCGAghD4MkEz0ZDZckhV4lAzACATQCBgEHAQEDCVkBAZAOAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Aug 2020 19:18:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 07CJI3oV149999;
        Wed, 12 Aug 2020 15:18:04 -0400
Subject: Re: [PATCH v20 05/12] LSM: Infrastructure management of the
 superblock
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        John Johansen <john.johansen@canonical.com>
References: <20200802215903.91936-1-mic@digikod.net>
 <20200802215903.91936-6-mic@digikod.net>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <779c290b-45f5-b86c-c573-2edb4004105d@tycho.nsa.gov>
Date:   Wed, 12 Aug 2020 15:16:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802215903.91936-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/20 5:58 PM, Mickaël Salaün wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> Move management of the superblock->sb_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> Reviewed-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20190829232935.7099-2-casey@schaufler-ca.com
> ---
> 
> Changes since v17:
> * Rebase the original LSM stacking patch from v5.3 to v5.7: I fixed some
>    diff conflicts caused by code moves and function renames in
>    selinux/include/objsec.h and selinux/hooks.c .  I checked that it
>    builds but I didn't test the changes for SELinux nor SMACK.

You shouldn't retain Signed-off-by and Reviewed-by lines from an earlier 
patch if you made non-trivial changes to it (even more so if you didn't 
test them).

