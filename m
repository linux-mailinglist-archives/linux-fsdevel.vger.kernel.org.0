Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C77D9F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfHALEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 07:04:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37398 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHALEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:04:10 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so23557608iog.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyrfV0ny/M1GUXVGlI7pscWcaouugm2uzojk14HjJq4=;
        b=pBf5a9/HF3Ba2nixtYKmrI9S00Abz8qmn+rwqM5HkxJuPU0ACP24eD00PBTmh0uoN8
         dI5ZEVUJK2Ptnqw3her+XYipQzGbdst02HFFuIU3ByrKbQ1B3GTajX7UXycbd8bZ4now
         ZSasGAlJx2OnXxyjIzF1DM1WoatXe13rkbczY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyrfV0ny/M1GUXVGlI7pscWcaouugm2uzojk14HjJq4=;
        b=CY256YX59Q+Wi6o5NwLHHhPoopDnP253Lf0uZL2TGFYk9vEFbtAC3K1lsfpezBctfn
         ObBXzRorlxRSYs4GYa58UU13HTfWyVNf+1MOrTkdWLueHlnA8GyktudymI6ZpWxNPey4
         ArXe9Tl1kj1wLPeGS1UeOYz9iSA+Q9AWJA5Hd80PPaF9dKBRPpVQZF+1c2EjXze/urrJ
         R5DI7hR7RYkRpe0CkB7kw9J7JgKMPIdj2wpbrFmWrlnmyNQKeRQYAbvHKCcVLFD6779D
         opruSMSqH/BNt1BTpFIV+d9RDn7giGMfS2Ser8x7uBNZtyM2kL3z0P1/hPIx01jYGZQJ
         qikQ==
X-Gm-Message-State: APjAAAVmskYWg0Nyu7l5S+oRD9FkuofcPmW6z6TXczl0mRDiqGXTAjGn
        tfcn5vRocAziK6YvNjjpPpXlB3x8iUNAg0h6qTE=
X-Google-Smtp-Source: APXvYqxyyNOG+gV1/kk4ACfnBxdI8w2ALmoEmcfZE8+IM7h3QDdX57asj+Mg7KXkeYl2xZmYN1SqgRcy79BlWmWyUlU=
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr41761993jai.39.1564657449712;
 Thu, 01 Aug 2019 04:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
In-Reply-To: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Aug 2019 13:03:58 +0200
Message-ID: <CAJfpegtr3-7q0VafdV-mTRyXb1Tbk5tUhgUTwK4RFGgj-Q=9dA@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup fuse_wait_on_page_writeback
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:17 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> From: Maxim Patlasov <mpatlasov@virtuozzo.com>
> fuse_wait_on_page_writeback() always returns zero and nobody cares.
> Let's make it void.

Applied.

Thanks,
Miklos
