Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15E6140B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 23:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJaWcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 18:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaWb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:31:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399F10FC;
        Mon, 31 Oct 2022 15:31:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y13so11902616pfp.7;
        Mon, 31 Oct 2022 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nXXo4ET/P13Jj8rdh3uTOW4cT8XJXJyx9jFU05ZLVA=;
        b=FnfW1bL/q3z703IQ/Zn9pzpTb/1ZwJ7fcu92DxFTlWw1BAg3rt6jDLF8PpRwwIqISx
         YYkLzg1/OUuRCWkIYOsjKfb1TocjnykHRkNRux5xxmVUJeRzXXVXTGoue8psiAW7LySE
         dr5/Ii+Fi5LKb3SRx47sGLNO3f5c/Xgy/CHunJj/pgIYKJoEprwMkSasnv8fyDbdYpRF
         yWwM7e7jAeSKbJNwxylU0Pd1ngOx3mwhK73UbyMLVcv98bKufizN/H5zWQMTG41coxds
         /lTW3P8czL+gpW8ZQwLZGd1Z+AdBJCQH8h1nLRKhdzhREICRfBxEcPvc/VU26nu/9RT2
         Sm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nXXo4ET/P13Jj8rdh3uTOW4cT8XJXJyx9jFU05ZLVA=;
        b=rpGofUZYQzrM5K0JzReXMFGSsA7U4PWuLMQJz68KQ/Xv625aGOeoOA50qDzhbQyNUW
         hnG16DhiaDvqM/MnupcCLUYLwHWlSupb41MzlsKhA5+8VlqokZ/xv4Dxge07rIglD7Lz
         rsfjKei1whLGkuKI5qe5UFSEgu+EnNHAxt+z2YGgnCrL53LWOgUfY5D2Y+xpgBBducmM
         SV7IBh8VNNW0/2mOAnR3wceZSSsD8v2n/3GBSp9hPb9knMYQzshZ28fTEUw/B8YVtL6P
         BcYHhc6cUiMpP+BB+aGEpyLPGmNz2rD/jR8owpT+nMBxRGW8n+jBjfrc/Wk3bq0Hsqnv
         Wi5g==
X-Gm-Message-State: ACrzQf1zRn+Q9e2n1YwM5oPbRk/UUNF454HrAX5ULQTM7UxWimL7YcRV
        KwaFsSfqNlX5Ogv0nQNi8lM=
X-Google-Smtp-Source: AMsMyM7TcxdRo0j/gD45XUaGBFcbAA1Nujb6cLp5ZzJfHgVF5C8l1xbzuicS+LA+A63+IdBIGLG4fA==
X-Received: by 2002:a05:6a00:841:b0:56d:3cf5:102e with SMTP id q1-20020a056a00084100b0056d3cf5102emr11673934pfk.47.1667255514365;
        Mon, 31 Oct 2022 15:31:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id x9-20020a628609000000b00563ce1905f4sm5124593pfd.5.2022.10.31.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:31:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 12:31:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kernfs: dont take i_lock on revalidate
Message-ID: <Y2BM1hR8M9Ckrpoz@slm.duckdns.org>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:32:49AM +0800, Ian Kent wrote:
> In kernfs_dop_revalidate() when the passed in dentry is negative the
> dentry directory is checked to see if it has changed and if so the
> negative dentry is discarded so it can refreshed. During this check
> the dentry inode i_lock is taken to mitigate against a possible
> concurrent rename.
> 
> But if it's racing with a rename, becuase the dentry is negative, it
> can't be the source it must be the target and it must be going to do
> a d_move() otherwise the rename will return an error.
> 
> In this case the parent dentry of the target will not change, it will
> be the same over the d_move(), only the source dentry parent may change
> so the inode i_lock isn't needed.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
