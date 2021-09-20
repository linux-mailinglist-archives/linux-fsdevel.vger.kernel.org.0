Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1278412832
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhITVle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 17:41:34 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:36485 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhITVje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 17:39:34 -0400
Received: by mail-pj1-f44.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so459916pjn.1;
        Mon, 20 Sep 2021 14:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ayxZn/lOlQR6TbkkaZBFMOItibmi4Bh0TfB4sua9Dg=;
        b=cV+CTzsBDkXGVCuwl377DfuN59I/vu0qphxX8zew/xNq+jGTlpj1sotZRDPJ3+fJOd
         /tjPDSytepJpeQg6mhNsNSBhqdnAjJfiib4S8ZYz+xrnoFKV8jZ/TXoAV8+N4B1bcR4f
         SbsXqdyPDXs4FwfiSFAlNrGMRyqUVBdE/gvI8jiMGBnccq2IuoNgPyxQvjnUM1XCECdl
         OgqtRQ/2uy6jew9Vp76yXthSIMpU0GMFZVOGPJoQOlzieJgTjXvORIcG7nq8+y0azWwc
         xi5R1xtaSDsvW4EMrlEcxWBWTC8blLxlv6Qep9r13nw8v4nkV5T/7LIKzaWG9aYphqIU
         NjvQ==
X-Gm-Message-State: AOAM531/5I+BJVIcl24ox+HTfadtC5C1rFarUDLb/7uZmsnwt1QtNldH
        WDGFuTGJGLpsGXZlJDlaz60=
X-Google-Smtp-Source: ABdhPJx1Az2oN5wV3HapNIpTDijDyVmric+3mpxs5EaEkRipPE4jz0ZZeyK4NeP32XsrEIfxd+X+Kg==
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr1253820pjb.112.1632173886429;
        Mon, 20 Sep 2021 14:38:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6e2a:d64:7d9d:bd4a])
        by smtp.gmail.com with ESMTPSA id x8sm14854198pfm.8.2021.09.20.14.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 14:38:05 -0700 (PDT)
Subject: Re: [PATCH v7 03/12] selftests: add tests_sysfs module
To:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org
Cc:     rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@ACULAB.COM,
        jolsa@kernel.org, andriy.shevchenko@linux.intel.com,
        trishalfonso@google.com, andreyknvl@gmail.com, jikos@kernel.org,
        mbenes@suse.com, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, reinette.chatre@intel.com,
        fenghua.yu@intel.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, bhelgaas@google.com, kw@linux.com,
        dan.j.williams@intel.com, senozhatsky@chromium.org, hch@lst.de,
        joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-4-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f33732f8-fd8e-abaf-6725-4a048bace2a2@acm.org>
Date:   Mon, 20 Sep 2021 14:38:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210918050430.3671227-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/21 10:04 PM, Luis Chamberlain wrote:
> +static void test_dev_config_lock(struct sysfs_test_device *test_dev)
> +{
> +	struct test_config *config;
> +
> +	config = &test_dev->config;

Please change the above into a single line (there are multiple
occurrences):

struct test_config *config = &test_dev->config;

Thanks,

Bart.
