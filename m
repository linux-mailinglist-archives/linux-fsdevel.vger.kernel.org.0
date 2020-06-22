Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F0203B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgFVPhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgFVPhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:37:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D98C061573;
        Mon, 22 Jun 2020 08:37:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so1375734pfu.8;
        Mon, 22 Jun 2020 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7I4FBHkC3xoY8dcYSORZ0nTLqrZS6hPMwq+XQvczidk=;
        b=O4wc8PnnSmhd0MtkI7mV9+Rlp5x+aav1eXppMIpW6e6vfWSVuBtqcKJrI+Dl6tSEjP
         bvirBl9ybJmqgaCDLsrfCPIXGkRWxij5h4/BfSq6kShUKoEhNP58McT+yPuUZxTpaVwB
         TB298vkuKHBamQZVx+oK8NINwJONAH5UZTiLezsdHCBeeqMK1zGWv4Bg8cSARNICaheU
         dXGCj/bN6VHS7IuItxM10WBT8+kpc1LmVhXTfBBXyQvCZTTaWEdnWbhHYiqque2UYmUJ
         BZ52vOqxIW6WYDuyGWcMt48OTGhyoXUCXb1z769cjgEgPuDYP+JXO65x1k2uisBtOVFd
         1tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7I4FBHkC3xoY8dcYSORZ0nTLqrZS6hPMwq+XQvczidk=;
        b=kT836hbHtzhmT3dpGL71djXTKME9NaFI4RFXGO0w5vF3W2M78hUXolmufpgaMZ0R38
         BcEP26XGr3M1dq2/18jWToICab2g3y2gQkFcdLKDGpCE1Mjmxvvrf/pDt5h93PmePCig
         fSUQdwV8JH+iQ3OnCRJpcHrVwTqhnq6mVja7Qmcrf3fppmW2uOslugH1Nkc7g1cUIdUo
         62fFD13fSx74vGfTFFCUgMenxJq6I160m+zYLNhavhNnBtjl5xQS/a9PhWazj/tai18d
         W9sH/A1T62t+/2srn/L2ka35aDY5wcgCfPHMVfyyUjpJ3Bj5rH/uKuMUG2cw0og8ALcA
         DmAw==
X-Gm-Message-State: AOAM531TZbPOKM83Ts0B+P/BnKmTcmf2nJObUkYnNIWVzZ+c1MA/M+Eb
        JG3LhreifoZZXZzJJTq61EOkQiY0
X-Google-Smtp-Source: ABdhPJzqNQNJOpVYmj9g0sA4GCXf+imfhXoZXk2cFTB51ukto7iCCL0jPlM4jDE1SVmc+idfGcCl9g==
X-Received: by 2002:a63:ca0c:: with SMTP id n12mr2298819pgi.216.1592840239667;
        Mon, 22 Jun 2020 08:37:19 -0700 (PDT)
Received: from ?IPv6:2601:1c0:6280:3f0::19c2? ([2601:1c0:6280:3f0::19c2])
        by smtp.gmail.com with ESMTPSA id y10sm11749397pgi.54.2020.06.22.08.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 08:37:18 -0700 (PDT)
Subject: Re: mmotm 2020-06-20-21-36 uploaded (lkdtm/bugs.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20200621043737.pb6JV%akpm@linux-foundation.org>
From:   Randy Dunlap <rd.dunlab@gmail.com>
Organization: nil
Message-ID: <20a39fd4-622d-693c-c8d6-1fbab12af62a@gmail.com>
Date:   Mon, 22 Jun 2020 08:37:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200621043737.pb6JV%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/20/20 9:37 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-06-20-21-36 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

drivers/misc/lkdtm/bugs.c has build errors when building UML for i386
(allmodconfig or allyesconfig):


In file included from ../drivers/misc/lkdtm/bugs.c:17:0:
../arch/x86/um/asm/desc.h:7:0: warning: "LDT_empty" redefined
 #define LDT_empty(info) (\
 
In file included from ../arch/um/include/asm/mmu.h:10:0,
                 from ../include/linux/mm_types.h:18,
                 from ../include/linux/sched/signal.h:13,
                 from ../drivers/misc/lkdtm/bugs.c:11:
../arch/x86/um/asm/mm_context.h:65:0: note: this is the location of the previous definition
 #define LDT_empty(info) (_LDT_empty(info))
 
../drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_DOUBLE_FAULT’:
../drivers/misc/lkdtm/bugs.c:428:9: error: variable ‘d’ has initializer but incomplete type
  struct desc_struct d = {
         ^~~~~~~~~~~
../drivers/misc/lkdtm/bugs.c:429:4: error: ‘struct desc_struct’ has no member named ‘type’
   .type = 3, /* expand-up, writable, accessed data */
    ^~~~
../drivers/misc/lkdtm/bugs.c:429:11: warning: excess elements in struct initializer
   .type = 3, /* expand-up, writable, accessed data */
           ^
../drivers/misc/lkdtm/bugs.c:429:11: note: (near initialization for ‘d’)
../drivers/misc/lkdtm/bugs.c:430:4: error: ‘struct desc_struct’ has no member named ‘p’
   .p = 1,  /* present */
    ^
../drivers/misc/lkdtm/bugs.c:430:8: warning: excess elements in struct initializer
   .p = 1,  /* present */
        ^
../drivers/misc/lkdtm/bugs.c:430:8: note: (near initialization for ‘d’)
../drivers/misc/lkdtm/bugs.c:431:4: error: ‘struct desc_struct’ has no member named ‘d’
   .d = 1,  /* 32-bit */
    ^
../drivers/misc/lkdtm/bugs.c:431:8: warning: excess elements in struct initializer
   .d = 1,  /* 32-bit */
        ^
../drivers/misc/lkdtm/bugs.c:431:8: note: (near initialization for ‘d’)
../drivers/misc/lkdtm/bugs.c:432:4: error: ‘struct desc_struct’ has no member named ‘g’
   .g = 0,  /* limit in bytes */
    ^
../drivers/misc/lkdtm/bugs.c:432:8: warning: excess elements in struct initializer
   .g = 0,  /* limit in bytes */
        ^
../drivers/misc/lkdtm/bugs.c:432:8: note: (near initialization for ‘d’)
../drivers/misc/lkdtm/bugs.c:433:4: error: ‘struct desc_struct’ has no member named ‘s’
   .s = 1,  /* not system */
    ^
../drivers/misc/lkdtm/bugs.c:433:8: warning: excess elements in struct initializer
   .s = 1,  /* not system */
        ^
../drivers/misc/lkdtm/bugs.c:433:8: note: (near initialization for ‘d’)
../drivers/misc/lkdtm/bugs.c:428:21: error: storage size of ‘d’ isn’t known
  struct desc_struct d = {
                     ^
../drivers/misc/lkdtm/bugs.c:437:2: error: implicit declaration of function ‘write_gdt_entry’; did you mean ‘init_wait_entry’? [-Werror=implicit-function-declaration]
  write_gdt_entry(get_cpu_gdt_rw(smp_processor_id()),
  ^~~~~~~~~~~~~~~
  init_wait_entry
../drivers/misc/lkdtm/bugs.c:437:18: error: implicit declaration of function ‘get_cpu_gdt_rw’; did you mean ‘get_cpu_ptr’? [-Werror=implicit-function-declaration]
  write_gdt_entry(get_cpu_gdt_rw(smp_processor_id()),
                  ^~~~~~~~~~~~~~
                  get_cpu_ptr
../drivers/misc/lkdtm/bugs.c:438:27: error: ‘DESCTYPE_S’ undeclared (first use in this function)
    GDT_ENTRY_TLS_MIN, &d, DESCTYPE_S);
                           ^~~~~~~~~~
../drivers/misc/lkdtm/bugs.c:438:27: note: each undeclared identifier is reported only once for each function it appears in
../drivers/misc/lkdtm/bugs.c:428:21: warning: unused variable ‘d’ [-Wunused-variable]
  struct desc_struct d = {
                     ^
cc1: some warnings being treated as errors


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
