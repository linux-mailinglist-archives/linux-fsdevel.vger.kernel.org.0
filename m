Return-Path: <linux-fsdevel+bounces-5362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D680AC46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89D81F211F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F274CB34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yep0MhUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6E1985;
	Fri,  8 Dec 2023 10:07:40 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5908a5d4222so528027eaf.2;
        Fri, 08 Dec 2023 10:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702058860; x=1702663660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C77TpInB1zh8d1IAOUInQ6yFu0SRsNtsyD+hY95J9tA=;
        b=Yep0MhUeeffOeU8wi45LEmbmRkSUjmwmfEYFDECp7+fx4EEuC/WG2baTWEWjYCKDNp
         pm3ZYud6HMsO5wSWS7S9XuwwtkMiTeG6fQVfnGKEHXFSiY20x9KpvbnnsHNUM3E+j+ES
         xvv6GvvUL75IM8ncuAbvgY+PVWG6CEH8ejXayeI1ya2+C7h2G+YUOU/r5KeX6fU7ikj/
         lvsSIv59x8aN4V8pv4Nh9S1dU2N7uyJq3gUz/qKdUCR6otdZnr3ZIGwcfPjJJrOlUalr
         goaALsSROs0B38Gp+u+cOum28GNGwikfkFain62AQmDNuKgYY2CPyD8pzN717yZM1AMC
         q+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058860; x=1702663660;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C77TpInB1zh8d1IAOUInQ6yFu0SRsNtsyD+hY95J9tA=;
        b=DOxoFhzxjQaeh4uhn7f4YzAYRSGZk+NEuvssJ3aN8pJ22oOkQwQcl5vq1hpwKkZEAG
         Tl5q4ITZSkyCNgQDimey/of8DMJ5KpWEB7+tTWCsi5e+t7ruXts8VVKR7Z5KkdWrsFy3
         Cw7PGCy2fShtwAaDFwNY1iJsmp9M0mLeCp4gMngii6sua0/3JgD8rf5ONvunlPrxEgkP
         /pJbZf/aeW+tsyxAuGvuycldG/JGiZZm5WUdlm5mzYj032GO4XOu4u3cbornLypNs1nh
         ePa+vUnTfisT9fMiMRhQd/4pWWkMxhVE07htS85kiBn/VwmaKonrYin67XrDzad+2UGI
         eSGw==
X-Gm-Message-State: AOJu0YzFSaEblJrxm8F2WVXArs+ScepAHtChWnbJgtAvJvtsuFbUX5N1
	IZJCLPo2z8MqymRtq5Pc+DcIpkb5ImQv/KQIPYU=
X-Google-Smtp-Source: AGHT+IFG9Wqckhd8+QJop7BFj37zOIOYAYHFNhLpTmBdHyZL9wutRVFbzd8r3gESFpX+rio/9ui4gOfULAIXNS5mAt0=
X-Received: by 2002:a4a:9882:0:b0:590:a673:8016 with SMTP id
 a2-20020a4a9882000000b00590a6738016mr184730ooj.18.1702058859753; Fri, 08 Dec
 2023 10:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7f0d:0:b0:506:9554:eef4 with HTTP; Fri, 8 Dec 2023
 10:07:39 -0800 (PST)
In-Reply-To: <ZXEuBnX4FTDdaqn0@xsang-OptiPlex-9020>
References: <20231204195321.GA1674809@ZenIV> <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
 <20231206054946.GM1674809@ZenIV> <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020>
 <20231206161509.GN1674809@ZenIV> <20231206163010.445vjwmfwwvv65su@f>
 <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
 <20231206170958.GP1674809@ZenIV> <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
 <CAGudoHGgqH=2mb52T4ZMx9bWtyMm7hV9wPvh+7JbtBq0x4ymYA@mail.gmail.com> <ZXEuBnX4FTDdaqn0@xsang-OptiPlex-9020>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 8 Dec 2023 19:07:39 +0100
Message-ID: <CAGudoHFReHsRviEMBwc2uSMkd72bB1b5RsWfBbEvY6HHSDSSuA@mail.gmail.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On 12/7/23, Oliver Sang <oliver.sang@intel.com> wrote:
> hi, Mateusz Guzik,
>
> On Wed, Dec 06, 2023 at 07:30:36PM +0100, Mateusz Guzik wrote:
>> Can I get instructions how to reproduce the unixbench regression?
>
> I uploaded the reproducer for unixbench in
> https://download.01.org/0day-ci/archive/20231207/202312070941.6190a04c-oliver.sang@intel.com
>
> as in
> https://download.01.org/0day-ci/archive/20231207/202312070941.6190a04c-oliver.sang@intel.com/reproduce
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in
> this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for
> lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>

thanks

Looks like this one will require a box with 64 or more cores to run
on, so my usual test jig is not going to do it. I'll sort it out in
few days.

-- 
Mateusz Guzik <mjguzik gmail.com>

