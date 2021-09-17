Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE740F194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 07:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbhIQFW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 01:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbhIQFW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:22:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A5C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 22:21:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g1so28047798lfj.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=m2zl0xOZ3wFhTOVRJ29+japJRUcwyRvdfaPZ9LcNaPNUqQYVu7S+H8r9nbKnOQik5U
         Sc7cL1hjGjoz9y+bx2MS0DwawE2tNKBKtt5l/IlgE0sI6H23P08U5652jDDDXH7K4h5v
         wX+guftn5JRAihqdPcx0RzlBn0up2RTnE/G3l6G2+2jmftw/vYB1CpWEqTP2i0SNTNJP
         1dA55zWdjKYmHF5hOQnme/RGAAAFukLuH5PjwVcdaCsDQxoKDmeATf+JpCE5IwaIpKIX
         suD+lguvbhwNl4usuqcpOc39dlFdl1nH7OQEDiOXIxCo8j5z3r840Ag9KUjGRePjKHXV
         m/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=bMCqulCVeH00gIrOEZVE2NFo46XneGzUPDjp1tx3gXTXpNeGlPn/DxDjgc/1A1hJlx
         uYYBQZqx+GIvRDJ5u2x7zXUdEeyzpn50/jjB5dOYDJSI8dU9EjoXHplsNUP/5/4IBGX0
         cFri7sC9+KKVwBln2lp2QqA6iIrqcKxqvTp41/rqtPv8iakuGdT36ff93z3HlrT3u8T+
         qxSHGxg/E3NlgA7UDbH9gAO7+sYu9hOtouNfmj7B0eJC0eKoPwDfpG81O/VxJltaJLJp
         dS9NtDN3JlFV5S89z1O2v4vb4UxSb+/BCvx3te64FGJ8OhQui/cLr2nqhMe1XBoUEoq/
         bhjg==
X-Gm-Message-State: AOAM532xCo6Ht+UB3JsCnTdZzucA/UodqZC5MlPbEf88wWbbozO7PPhp
        ECQTIx5oEsWHT76DfwRTWnAZmW1UW5/fcf4Nt/Q=
X-Google-Smtp-Source: ABdhPJzFJJKIW3KQDHT7Cn5q4ny5wqt8CP85TyJpBpPM0Brix1pdtEdpx57dApB/BhTNS7iCJZtXMU6ack8TTH33Vk8=
X-Received: by 2002:ac2:483b:: with SMTP id 27mr6729524lft.644.1631856092603;
 Thu, 16 Sep 2021 22:21:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: maxwellagusdin8@gmail.com
Received: by 2002:a05:6520:47c4:b0:139:1b10:ad9d with HTTP; Thu, 16 Sep 2021
 22:21:31 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Fri, 17 Sep 2021 07:21:31 +0200
X-Google-Sender-Auth: q-WbBr00O3O6_06CjhGECWzl0FA
Message-ID: <CAK5X1Sc7FNq82=0h3uBehLopAxQeLW-a7uoF-Pf+ax2Xm44ceA@mail.gmail.com>
Subject: I want to use this opportunity to inform you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I just want to use this little opportunity to inform you about my
success towards the transfer. I'm currently out of the country for an
investment with part of my share, after completing the transfer with
an Indian business man. But i will visit your country, next year.
After the completion of my project. Please, contact my secretary to
send you the (ATM) card which I've already credited with the sum of
($500,000.00). Just contact her to help you in receiving the (ATM)
card. I've explained everything to her before my trip. This is what I
can do for you because, you couldn't help in the transfer, but for the
fact that you're the person whom I've contacted initially, for the
transfer. I decided to give this ($500,000.00) as a compensation for
being contacted initially for the transfer. I always try to make the
difference, in dealing with people any time I come in contact with
them. I'm also trying to show that I'm quite a different person from
others whose may have a different purpose within them. I believe that
you will render some help to me when I, will visit your country, for
another investment there. So contact my secretary for the card, Her
contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,
