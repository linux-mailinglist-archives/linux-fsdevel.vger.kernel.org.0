Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80F4420044
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhJCF4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 01:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCF4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:56:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB0C0613EC
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Oct 2021 22:54:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b20so57043718lfv.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Oct 2021 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=xRc3IHUizmviQEjT/aA/BX2eK4NRIQ6MOKbVgrtXYgk=;
        b=fdEJqFcb+QVnVAQ6DRvH0+0m6BiZhxtj+NCloXE4EU2wnL44Pply6WxHmAiQNBJdKc
         zAFzGoQMBj9SFQe1GWj6Rt6EqlFSQSPUrfAXRdvh8EOaQOiZcLDV+3HYuZnqHMNP18op
         BFBn+l7om6b8pqpxaSlaoe1b2dcydmYxOHurGZnRb9uhhf31n2pXVRQa+2dD/QQ3Lk10
         l25MwZHZQ5yr5YJUyvglKs9Z4pxHXpkEq4LcDf1heiXcXF8YYjwYr0HXEQ5v/7dAMFkH
         ZGR1gEWeSeMeGuVf/1MOhaQilL1vWJ6HoTffOtV2s1lAWPzC8G0oUc4BHVnNZOvWTkSk
         Phnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=xRc3IHUizmviQEjT/aA/BX2eK4NRIQ6MOKbVgrtXYgk=;
        b=ynDoP1vrZG7DEBTa3xi2w0JWucOCpQTBv+xWnPfZ3Fk+XyIhago2K/02pV4MGMbOTt
         ZidBLs341S29x3ls3cvAk6gRlZSBfzrN6/5JzFInZBscsXaWSvxaquq98fTcVpAZYvUv
         L6JvSjw4iQ4/aVnIkBsk3Zn6Ms0y6HvihFtWmy3OM80fBjM7vxPoInTTZ5iqn6YtVJ69
         pf28mH+2YppslG4BZ/74TyV56k0qDihRxRVBQ4Zlei01Ebs3V1WoFxVU9anbGAg2chns
         xBnuGy/3U6pcfXwJ+A7qUqlh1RxXXBnviCAhkjEkmBe2I6kXwq/8aTPawSjmXtmwbql6
         l6kQ==
X-Gm-Message-State: AOAM532T/jftbOYzOC/TDpDOEBvSaJJwHWddGhbYo/hm51dASZ6qRCB6
        9uRmdw2hgRfeiuiBUVXzrgATngchaHz6KM+rvIQ=
X-Google-Smtp-Source: ABdhPJx7qH4rQGMpfhhwlOzuYJRA8Sc+iVd7RFmSDxeGnA1N6EZB3MmTRyK6dFIJWTxOHUbIEriGZzkdjaKP6LQfDhs=
X-Received: by 2002:a2e:8852:: with SMTP id z18mr8019966ljj.412.1633240453773;
 Sat, 02 Oct 2021 22:54:13 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: info.bfinfo3@gmail.com
Received: by 2002:a05:6520:47c4:b0:139:1b10:ad9d with HTTP; Sat, 2 Oct 2021
 22:54:13 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Sun, 3 Oct 2021 07:54:13 +0200
X-Google-Sender-Auth: 4-6foZPC63deeomGMWgzGxuEg8k
Message-ID: <CABCrZeP=8FEhu2MZOfS2eYMUTymh1du_w-rOKgMzqMyDXrgoPg@mail.gmail.com>
Subject: This is to inform you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

How are you doing? I am very happy to inform you about my success. I'm
currently out of the country for an investment with part of my share,
after completing the transfer with an Indian business man. But i will
visit your country, next year, after the completion of my project.
Please, contact my secretary to send you the (ATM) card which I've
already credited with the sum of ($500,000.00). Just contact her to
help you in receiving the (ATM) card. I've explained everything to her
before my trip. This is what I can do for you because, you couldn't
help in the transfer, but for the fact that you're the person whom
I've contacted initially, for the transfer. I decided to give this
($500,000.00) as a compensation for being contacted initially for the
transfer. I always try to make the difference, in dealing with people
any time I come in contact with them. I'm also trying to show that I'm
quite a different person from others whose may have a different
purpose within them. I believe that you will render some help to me
when I, will visit your country, for another investment there. So
contact my secretary for the card, Her contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,
