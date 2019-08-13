Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D178B58C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfHMK2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 06:28:12 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41934 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfHMK2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:28:12 -0400
Received: by mail-ed1-f44.google.com with SMTP id w5so3622907edl.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 03:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pm/k0ZghMhmS+inYuBmY6GUEyiSfNucazFI3jbEJ9Sc=;
        b=ZunnC/eijdKun1J1RYdiJlA/XFJBatU0d830BOD1xOLCon69f4C0+ptmpfwfwbFsoA
         LG9/n9Fj4InFSdQ4ddD39QU5zPOhxw/aJc2JoF31fjW3vRL9in3L2kdcmG9ZcmMfMfMH
         UbRSp5wB1u+V9cwODZY+vdhtMCqXhDQJnD84SqSNb5cxZ4on7OeGVuAWgXQAjdIu7Ylb
         cHZL1VkcmDcKVUCa40kJdv1gdBT2Z8PriMGlP0jZaUUy48B7uRZPJ4r2Q7MGM94p00cL
         6GQa/woSVNo/1GU5l+FDXbi101ZGf/Hto4NdapxzWX2QCvMSLxustI0yt67QS4w394rd
         eiLw==
X-Gm-Message-State: APjAAAXAqO8E41rZ/JSOTHNelVt1Vp29OLNFZmXwM5mkegDD3O70wr0K
        QefHMdz8E348lNDFfaraWxI=
X-Google-Smtp-Source: APXvYqxVZAB4nEywX27Y9B7owJYS/ZWogFLE0ci4CK5GctuXwWwHaINLT/JeH4T3ep7sxjrVduGEAQ==
X-Received: by 2002:a17:907:4362:: with SMTP id nd2mr15897136ejb.29.1565692090914;
        Tue, 13 Aug 2019 03:28:10 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id y30sm1263838edi.95.2019.08.13.03.28.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 03:28:10 -0700 (PDT)
Subject: Re: [PATCH 11/16] zuf: Write/Read implementation
To:     kbuild test robot <lkp@intel.com>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     kbuild-all@01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <boazh@netapp.com>
References: <20190812164244.15580-12-boazh@netapp.com>
 <201908131806.7h0XFklW%lkp@intel.com>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <05704059-8050-835c-156c-2ffa897e86a3@electrozaur.com>
Date:   Tue, 13 Aug 2019 13:28:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201908131806.7h0XFklW%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/2019 13:23, kbuild test robot wrote:
<>
> 
>    fs/zuf/rw.c: In function '_zufs_IO.isra.18':
>>> fs/zuf/rw.c:371:1: warning: the frame size of 8712 bytes is larger than 8192 bytes [-Wframe-larger-than=]

Will fix
Boaz

>     }
>     ^
>    fs/zuf/rw.c: In function '_IO_gm_inner':
>    fs/zuf/rw.c:569:1: warning: the frame size of 8720 bytes is larger than 8192 bytes [-Wframe-larger-than=]
<>
