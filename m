Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662FE6D3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 20:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390494AbfGRSTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 14:19:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45545 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:19:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so28241793lje.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gepmqZ8N/IE1dD9ivKS4WqYoEjZkViTT4tcrJbEnbOk=;
        b=hz94MbDILZQNajQa2trZ7qSP+dksrJ1mAn7+S56JhO9w6m2RoO+0OT5YlB/RoWVZsm
         b6VzRDPrYK6DWpUJo2nniO3XvejJMPKKxgv6OvnMr/AqDX/Q+A97QqUJ3nnZY+EcO0B5
         fNB3N40k3vyszAKIDXrJNNSSZ9MG6v37aATJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gepmqZ8N/IE1dD9ivKS4WqYoEjZkViTT4tcrJbEnbOk=;
        b=ia9z6O1ktgarrQmMI1B1hQ06KsbfiDYgSg2K6gHh9tWPfQcuNw26uib99ycGFsrn9f
         aAqMGzp00ZeZgRLtbbhpmxoNxrD03smzCG6jllPyaiFVr13Pl3EdMW/c9VPcgsNZgK9n
         XVlV5oHXMX2L6gi63NqqB7YRzuQojdmPFO2AnmCrmOpC6ASGnmasHVpLmK5oGSJLTLpa
         8zzKDAmLp07p2r9o8iKSMa3u1CaWiWJV9+IS9pI8IgQRbcvBavHBOCevFFkUQJ5SdrEG
         6XEe02+Xidk0WDEhhANUDiF3ZN1BWJJorjglTGcxy16RUW5gqYL2cIBmt42RS3MGYbz6
         aMcQ==
X-Gm-Message-State: APjAAAU70CqsryydyGnFEebTJwEo37Ls2krQ1c5iUAg6e6VkzMldB9XS
        hjiGciXUb0d8FDRvO2mhiw5pNubIlOc=
X-Google-Smtp-Source: APXvYqyLjMuX4xyBVU51qYZhP6zxz4NTvvqSQDRk9CwX1UJSe7NxO39LfLYyff4vKfL9t8gtlpehbA==
X-Received: by 2002:a2e:2b9d:: with SMTP id r29mr25068844ljr.181.1563473986103;
        Thu, 18 Jul 2019 11:19:46 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s21sm5276480ljm.28.2019.07.18.11.19.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 11:19:45 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h28so19881179lfj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 11:19:44 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr21790208lft.79.1563473984522;
 Thu, 18 Jul 2019 11:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190718161824.GE7093@magnolia>
In-Reply-To: <20190718161824.GE7093@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jul 2019 11:19:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whewBiKzpsO73Y38SAPSktxD6gUuEr2ANC8Z_3JPiqk3w@mail.gmail.com>
Message-ID: <CAHk-=whewBiKzpsO73Y38SAPSktxD6gUuEr2ANC8Z_3JPiqk3w@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: cleanups for 5.3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 9:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please let me know if you run into anything weird, I promise I drank two
> cups of coffee this time around. :)

Apparently two cups is just the right amount.

                 Linus
