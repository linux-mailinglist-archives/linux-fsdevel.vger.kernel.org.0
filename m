Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A249DE4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 10:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiA0Jo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 04:44:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:16502 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238758AbiA0Jo2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643276668; x=1674812668;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding;
  bh=dk0qamhX2TbtdZHxZwkI3zlHxXhVxx0UNGFBByp7cwQ=;
  b=jFfHa66eUP05WZJUGGMSnrDlJqW0ew9ltXO+8UC57mEEQjD4rCpjfNXC
   mqBRml2VfMy7I7aMG9FFOm8zgmzlxfZ2k0Ge2uxKr2zlbFlB+lztxgbW8
   g2fz4cQjNysHqMYiDSkLbnSCoFxDyZQT4AB2u+wDCYSGzycAt+d+MnCX+
   HzoQ3+7nRVUTkqctLds+C9DcIhLEvkS98Iouu2RVfcsvrkZb01Yb075jS
   4xDHxLCDLL1LY9QAUbAsnAvuE/QZl6Qa7KI5rzMSpwtnk+ciV48tHtJpa
   RqfGuIpjxVvhhNkvIXuqKN2yP3HrxOKQMKrg2Rlj98NgoXhj/z2ssMomY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="227474899"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="227474899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:44:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="618268633"
Received: from johnlyon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.16.209])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:44:23 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: mmotm 2022-01-26-21-04 uploaded (gpu/drm/i915/i915_gem_evict.h)
In-Reply-To: <6b4f3d82-01e8-5bf3-927f-33ac62178fd5@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
 <6b4f3d82-01e8-5bf3-927f-33ac62178fd5@infradead.org>
Date:   Thu, 27 Jan 2022 11:44:18 +0200
Message-ID: <8735l9y0lp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Jan 2022, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 1/26/22 21:04, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2022-01-26-21-04 has been uploaded to
>>=20
>>    https://www.ozlabs.org/~akpm/mmotm/
>>=20
>> mmotm-readme.txt says
>>=20
>> README for mm-of-the-moment:
>>=20
>> https://www.ozlabs.org/~akpm/mmotm/
>>=20
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>=20
>> You will need quilt to apply these patches to the latest Linus release (=
5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated =
in
>> https://ozlabs.org/~akpm/mmotm/series
>>=20
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
>
> on x86_64:
> (from linux-next.patch)
>
>
>   HDRTEST drivers/gpu/drm/i915/i915_gem_evict.h
> In file included from <command-line>:0:0:
> ./../drivers/gpu/drm/i915/i915_gem_evict.h:15:15: error: =E2=80=98struct =
i915_gem_ww_ctx=E2=80=99 declared inside parameter list will not be visible=
 outside of this definition or declaration [-Werror]
>         struct i915_gem_ww_ctx *ww,
>                ^~~~~~~~~~~~~~~
> ./../drivers/gpu/drm/i915/i915_gem_evict.h:21:14: error: =E2=80=98struct =
i915_gem_ww_ctx=E2=80=99 declared inside parameter list will not be visible=
 outside of this definition or declaration [-Werror]
>        struct i915_gem_ww_ctx *ww,
>               ^~~~~~~~~~~~~~~
> ./../drivers/gpu/drm/i915/i915_gem_evict.h:25:16: error: =E2=80=98struct =
i915_gem_ww_ctx=E2=80=99 declared inside parameter list will not be visible=
 outside of this definition or declaration [-Werror]
>          struct i915_gem_ww_ctx *ww);
>                 ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Thanks for the report.

This is only visible with CONFIG_DRM_I915_WERROR=3Dy which depends on
COMPILE_TEST=3Dn. We use the "HDRTEST" and -Werror for development and CI
to keep the driver clean, but it's not really intended for general
consumption. Usually when something like this even hits the tree it's
because of a merge mishap somewhere down the line.

BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
