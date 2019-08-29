Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B60A19B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfH2MOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:14:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfH2MOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:14:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so3165988wrr.8;
        Thu, 29 Aug 2019 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g6fQr58D2A40FvH0simm71xGSDIeFGyQZqgWXUgFWVY=;
        b=EKVBjDVW9RSSsuGVKwJg9XdPQZP3nPqNBLIQbnweHiW1qdsbbBVQ2EwIIeCP/YjkhQ
         b0ZQXKZkbwR1G+h1ftlcav7i6dOdTJ+fsBgzJOv2v1rYER9jkeXwyi3vpL1W5cvK6cmA
         rTJPfJOxCUJpcpH2xtnKDbOpdrBqrmITUvvknvxgLadPa83a4NQIfqUWb7zkwJVFUZtP
         CO6qDp1zaJsRkIHN3VQVgUCnA2mwrhs2FoAsyOZ30f+ubYdw86Wwk+aAXr0auKdJhAg4
         oKWP3owdsXOgRZJFoxQLRJTBcqZUKu6RDU1RsjkUF3gODKy4YBJy7c6zyaHnXWEs43Hx
         VARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g6fQr58D2A40FvH0simm71xGSDIeFGyQZqgWXUgFWVY=;
        b=N9opEtSUwfGZV4siC+7srgovCEiY28eV20O7V/27uHRFlp+AYD7cyf0Zh7vWbDzMZ+
         edafZDKw4Ofg/oj8q+KYQ7tN2oS0F14S5bIRWyjWheuPX2RiZugR5u5zGixlfSDFCZwN
         hVCGaDQ9+Oxs4tw2HDDLbsjUKDQgZl1zmiHt7xcci4nRJKAYetpqLH7elsSDzB0CWPyn
         ndsGPhllZ9IrxkW7naOaaWBCUqCd4ixzuP477K8Fb79ZKSwnYFBnv/178pbns0/yDSU+
         u2wCsEFJPnTuOhomET9AMYtFSUcXOlUrlTiN984C1c8c1TbNAefr1vQVmZOclydw9o3r
         D3Sw==
X-Gm-Message-State: APjAAAWk/USQl7WoQnnnSt4kygKfng53wgKDfaD7aIRS3UvOM9bLiXUS
        54+qRWgdbmQBl+UXUgvRGxk=
X-Google-Smtp-Source: APXvYqx+hSZNfO2MPixBonI1vY368TbshRm/+4s8x1yBJDMvdY3MjoTuP2w/gjxF09XVXNJXgtPXjA==
X-Received: by 2002:adf:e286:: with SMTP id v6mr10673358wri.4.1567080881576;
        Thu, 29 Aug 2019 05:14:41 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z25sm2843048wml.5.2019.08.29.05.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 05:14:40 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:14:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829121435.bsl5cnx7yqgakpgb@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 28 August 2019 18:08:17 Greg Kroah-Hartman wrote:
> The full specification of the filesystem can be found at:
>   https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification

This is not truth. This specification is not "full". There are missing
important details, like how is TexFAT implemented. In that specification
is just reference to other unpublished documents. So it is classic MS
way, they release something incomplete and incompatible with their own
NT implementation, like with FAT32 vs fastfat.sys.

I would be very very careful about existence of such documentation until
somebody implement it and do some testing against MS own implementation.

-- 
Pali Rohár
pali.rohar@gmail.com
