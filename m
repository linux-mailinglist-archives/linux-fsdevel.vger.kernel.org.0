Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7887A522A30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 05:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiEKDMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 23:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiEKDMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 23:12:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034A45796;
        Tue, 10 May 2022 20:12:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 137so635879pgb.5;
        Tue, 10 May 2022 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2MBN0zAn4D9ezzvtFqR3BrhbtifUhq904sSLoPSl8Gg=;
        b=OH3/AiTSfdYV426FLwS5odKSvQ6zAXUDpYal67qusApQXatvj5YUhB8Xnzkd5Uga2N
         92qc2Y4cFUAupDnI6aiuK7qkkafx62Vla7PRAn9lwS6+9URIwNp7HZVdbtBazgz4o80X
         702IC20TiPakyeONU3K8nSb3lXh4zK+hk+249Js2WkAwTcAPLwPbg/69XDN4YQEOQasT
         mgYGge8LN8TLkmTT9buWJiZez7aFG34mWAz/Ticup+afm9L+/VIF/UAz7yBx3d5nFnTN
         rMhZ5FuQ2YZdIpOqulGf9EcKKZuCC4WAaU6uuAtBrJBEmZpcmRpiPrIgFvoCqxSdF+1i
         lbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2MBN0zAn4D9ezzvtFqR3BrhbtifUhq904sSLoPSl8Gg=;
        b=OobcuAgA8BYC1Zi0K+qoXu7fSxgM+4+nIQjK1N/9lw77pvEw+NrFP02bgcyjZtavc5
         h542pWNWsBNRx5tkZzLzThRk/VYK4GqezadlI2bCXK6Z7xG3KHflurMT5cxn+Pd4ppZ7
         AFBlq4qGWMghb/n/5Bkq+8PttolqbY3hbYUf12n0MeeYf+nFCG5bNHgQKvHJkry8W2gp
         AE8zCRrpeihTjSmAgm5nbUoJrXG1UBGCsAAUJT85UighSsu41JsOsSnUbBpHjpz03v/O
         +KMjkLljow1K+x8HL8XM9awti3yycb+uhBFbr38UBJxJ9bXLGhor83vHYag7+aXE90Ct
         X2ig==
X-Gm-Message-State: AOAM532oXgyy3OxgSkmbPO0ADQ1b9T2wLltf9Ft9bc3UV0oJiibPbvXK
        Cq/THsFNThKj2KimIPc/Z/0=
X-Google-Smtp-Source: ABdhPJwUnDTfZUFHgHXqErgtlhY8Q79APm2Ey84kG+KC6CvYcMygKomgghJWTa+Yd+LiAI0zaxqmEg==
X-Received: by 2002:a05:6a00:1a8d:b0:510:510f:d8e1 with SMTP id e13-20020a056a001a8d00b00510510fd8e1mr22928042pfv.83.1652238725019;
        Tue, 10 May 2022 20:12:05 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b0015e8d4eb1d2sm389038pld.28.2022.05.10.20.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:12:04 -0700 (PDT)
Message-ID: <627b2984.1c69fb81.9002b.15f9@mx.google.com>
X-Google-Original-Message-ID: <20220511031203.GA1492365@cgel.zte@gmail.com>
Date:   Wed, 11 May 2022 03:12:03 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, corbet@lwn.net,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6] mm/ksm: introduce ksm_force for each process
References: <20220510122242.1380536-1-xu.xin16@zte.com.cn>
 <5820954.lOV4Wx5bFT@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5820954.lOV4Wx5bFT@natalenko.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 03:30:36PM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 10. května 2022 14:22:42 CEST cgel.zte@gmail.com wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > To use KSM, we have to explicitly call madvise() in application code,
> > which means installed apps on OS needs to be uninstall and source code
> > needs to be modified. It is inconvenient.
> > 
> > In order to change this situation, We add a new proc file ksm_force
> > under /proc/<pid>/ to support turning on/off KSM scanning of a
> > process's mm dynamically.
> > 
> > If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> > of this mm to be involved in KSM scanning without explicitly calling
> > madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
> > the klob of /sys/kernel/mm/ksm/run is set as 1.
> > 
> > If ksm_force is set to 0, cancel the feature of ksm_force of this
> > process (fallback to the default state) and unmerge those merged pages
> > belonging to VMAs which is not madvised as MADV_MERGEABLE of this process,
> > but still leave MADV_MERGEABLE areas merged.
> 
> To my best knowledge, last time a forcible KSM was discussed (see threads [1], [2], [3] and probably others) it was concluded that a) procfs was a horrible interface for things like this one; and b) process_madvise() syscall was among the best suggested places to implement this (which would require a more tricky handling from userspace, but still).
> 
> So, what changed since that discussion?
>

Thanks a lot for your information. 
However, the patch here is slightly different from your previous discussion: 

your patch focuses on using procfs to change the madvise behaviour of another process,
but this patch will not modify the flag of all VMAs of the process. It introduces
a new bool ksm_force to represent this forcible feature of KSM based on process,
which is independent of madvise. the same way, process_madvise is a kind of
madvise in essence.

> P.S. For now I do it via dedicated syscall, but I'm not trying to upstream this approach.
> 
> [1] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
> [2] https://lore.kernel.org/all/20190515145151.GG16651@dhcp22.suse.cz/T/#u
> [3] https://lore.kernel.org/lkml/20190516172452.GA2106@avx2/
> [4] https://gitlab.com/post-factum/pf-kernel/-/commits/ksm-5.17/
> 
> Oleksandr Natalenko (post-factum)
> 
