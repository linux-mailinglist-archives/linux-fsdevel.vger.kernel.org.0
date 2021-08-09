Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE43E4E24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhHIUwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbhHIUwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:52:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B1FC0613D3;
        Mon,  9 Aug 2021 13:52:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so10510897ljo.12;
        Mon, 09 Aug 2021 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dK575eflD+STye7Op1lRK6nqKdgr0fcfkvv4bBDnEnQ=;
        b=dsxdF+eBSn/90W8Q0YlAKuarE7/CMiCbElHS7lqpn+7mXr0Ks4IlkvFFDJFfxjfclT
         kpMIfbETD6N8E0/Hy4PzQg5a3aGaIe0PGSTAYxw/h8Fpda2vFvYVvcQrWPjHwDYlQg9A
         LGye2a/52ekUVE/1AXRIxt4B3x3eBNi0TtSuxYDCMCG6xrL814dXEiOpCMIjTzUuqZD2
         WO0IhfUmRVEMtu+MGmgAuBs7yKRqE5UHM+CJP6Qa4AU+oxFuhDNaoAmZcksFPqppnR9o
         sJ4VIwl4T1B3NbjC/XNMFh2pei+Y9IlgowjD9s3krz7uaxNf8uObKMM0jrjNpwrpDEaS
         zrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dK575eflD+STye7Op1lRK6nqKdgr0fcfkvv4bBDnEnQ=;
        b=t3fesBRLPGFLVTB438pncdPNobvlYoiOhzxK7bxEeeVSSzji+VODiCPns4EDxAyQw8
         MhKzedviFOBm2Z3aSuahzyKWi4OoVfDv4Ar2w/Xk7y5UmW1jD27Byjz5lb2nFioJpLcg
         m8OKABcRGQkx/Ms+ZjWr3nSMCFxls7E1jDEbX/gleg7+ZNH5dBJkyv/CJhZTjSyipBPG
         fBeit+5XIp7NKOmKJa4DePXtgzn+dp2Edw3N+zPiRC4iG19UPuotTVlsXutF3C6QXnbI
         ASX/P95dvrM0maT7wowfbpetQHJU2cweupKWR9Q4GowWnlF3pFNrRr0V/nzGuRy3XZEe
         wRbg==
X-Gm-Message-State: AOAM530vcDZ0ERgETcuRfL6Whw/u9azYBGp84UgGOQoc4QABN9TyCh1a
        HfuySECEUOC3hUuj/Tygo2c=
X-Google-Smtp-Source: ABdhPJxdAmIIMREvt7Qdl08XDDa3yv5ckIQSESbS+K1Ck04daVHWiCCfZLO5pN71JjJxDXTF3KG+2g==
X-Received: by 2002:a2e:3206:: with SMTP id y6mr1985938ljy.187.1628542336977;
        Mon, 09 Aug 2021 13:52:16 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id c10sm1283899ljr.134.2021.08.09.13.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 13:52:16 -0700 (PDT)
Date:   Mon, 9 Aug 2021 23:52:14 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 05/20] ntfs: Undeprecate iocharset= mount option
Message-ID: <20210809205214.mual4t7ipppc7h3v@kari-VirtualBox>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-6-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808162453.1653-6-pali@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 08, 2021 at 06:24:38PM +0200, Pali Rohár wrote:
> Other fs drivers are using iocharset= mount option for specifying charset.
> So mark iocharset= mount option as preferred and deprecate nls= mount
> option.

Documentation needs to also be updated here.

