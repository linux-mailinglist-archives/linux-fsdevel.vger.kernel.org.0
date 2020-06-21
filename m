Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D87020281D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 05:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgFUDJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 23:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgFUDJN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 23:09:13 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582BA247D4;
        Sun, 21 Jun 2020 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592708953;
        bh=wesJaYoH4sgcCLUaO2ZpVbTx4pbsV33gmVXHM7zIcO8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ky8fJqKQEptleqZ5FNOiqQ3Vm8sg04hm6LFSB9WgsqdtVI4X7Ab624iUFtCjCCukw
         4Ai31KFMyArSLPN1StHvriPH3k9IgvoshraDRCUZWiprKGLzO7XejZUveBFJ8zbfLG
         vD9qZsODa5G7rELklLnbc+T0a7pR06v5x0SHuLfc=
Received: by mail-oi1-f181.google.com with SMTP id t25so12370306oij.7;
        Sat, 20 Jun 2020 20:09:13 -0700 (PDT)
X-Gm-Message-State: AOAM531kmC76gHLRffXd/PVJ+X2g4u2PEoOhOXuIgEZfRhRMsJWMJFSg
        ged+9DHNDzUUDHKxByuGwQcEX4+fw8GqJFIoUQw=
X-Google-Smtp-Source: ABdhPJx3AYakaeU1ViKzYLUbb7aypyBVmHmxt7r9vXtUCNpoB6rFX6TvAFTCMt1JYFnFkrIeM9sx9PQLzsG2fVUnmk0=
X-Received: by 2002:aca:5310:: with SMTP id h16mr8276040oib.163.1592708952742;
 Sat, 20 Jun 2020 20:09:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1d8:0:0:0:0:0 with HTTP; Sat, 20 Jun 2020 20:09:12 -0700 (PDT)
In-Reply-To: <20200619083855.15789-1-kohada.t2@gmail.com>
References: <20200619083855.15789-1-kohada.t2@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 21 Jun 2020 12:09:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9qRx5q57xwG-d6-MzW-DK9jYAecX_6KuecCAhxrNbmmA@mail.gmail.com>
Message-ID: <CAKYAXd9qRx5q57xwG-d6-MzW-DK9jYAecX_6KuecCAhxrNbmmA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] exfat: write multiple sectors at once
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Christoph Hellwig <hch@infradead.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-06-19 17:38 GMT+09:00, Tetsuhiro Kohada <kohada.t2@gmail.com>:
> Write multiple sectors at once when updating dir-entries.
> Add exfat_update_bhs() for that. It wait for write completion once
> instead of sector by sector.
> It's only effective if sync enabled.
>
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
He didn't give reviewed-by tag for this patch.
You shouldn't add it at will.
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
