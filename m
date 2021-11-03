Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50974444643
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhKCQwE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 12:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhKCQwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:52:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AEBC061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Nov 2021 09:49:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so3202878ilo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Nov 2021 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RkjMpeIuQ6aVWCs6FPMVIVUmVZwq7aWhwwHDvLPHoTA=;
        b=KicifnRFUfO4N9gaBjWUeuCchiYARsN8O1co+rO5IPT91uvvueOb0wsNsI11GdxVwJ
         dr9v6erho2NSiuAeQPjWWXr80/aDVX4ZDGtF2bYMrGeduV8774afaJs3cID0VrxXXw7W
         JDNCz20doyAvjpa932g4VxBDygv/KK4Hwh9BB6Swam9PLtudLuRnmWMqKFmrCPti0oN6
         3OZoxOISvBEHzZfHQFfitqzxdyzkjiYvSP50xycioY8b7q/U3fNpFPjIe+8bUg6ZzHGT
         Rdiyer48xVYTxzp41hAy+B1fxpvmAGO5SZ5uQpOd5wdpNL64m7eSnlE6qoHNEWewrATl
         tLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=RkjMpeIuQ6aVWCs6FPMVIVUmVZwq7aWhwwHDvLPHoTA=;
        b=lA8HCf57Jjtq8cmfqaMzMfL1WVgFDu1/1cEwxjrtrOweskvjS9gH54DRZbbWMe5U3v
         HaAsCjNIgZjNk1muASx0761mnEhnrRsvOTh6ZWIszjCSZdEoo4PJzm688aXLhby5lmuR
         3PwVMbOqS5zhkHm4SVZoNIqJamSYqQPJ2eclr6kuyJi8NBD4ojWSjrJPOUNPlE0wpsp9
         zN4hCRJMGBAEgwGjNwOeQ0S53G5sImBKOgA70FWRASB6Egij8+Ahb+SDlKfS/9byvuuR
         yAitTVmNBFU6zUqIGA/2dGmsBOrUA7uX/fY+gPqSyrN6Oyt8wxOMO98fjMSn7j97WjR5
         yRUQ==
X-Gm-Message-State: AOAM533bfGGA90VtOV5Ftg1ZfcVR0gHUkAOmCoRUQHrbtn9yx3B+kd/k
        3epGk6eChC/SfSQzg2sLYFMU4diVvV+2XmxKCnI=
X-Google-Smtp-Source: ABdhPJzDZdGYiXBK4LHoEf4nsJbCPFz0PgWUFSUy6M3Q4PINGqDOM979ILAXeEjz4rLCT609Uhbd5D7Dop6EpQ1n0zc=
X-Received: by 2002:a05:6e02:1848:: with SMTP id b8mr6349174ilv.299.1635958163970;
 Wed, 03 Nov 2021 09:49:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsdaniella.kyle@yandex.com
Sender: marksmithtinufelix@gmail.com
Received: by 2002:a05:6638:16ce:0:0:0:0 with HTTP; Wed, 3 Nov 2021 09:49:23
 -0700 (PDT)
From:   Mrs Daniella Kyle <mrsdaniellakyle6@gmail.com>
Date:   Wed, 3 Nov 2021 09:49:23 -0700
X-Google-Sender-Auth: kY5Mgx72WX63GBhVTYyCO1hJNRE
Message-ID: <CA+EzCkr4+A=h3ZA1jNaO5PpgS4M7LpScPb39OCAVex9JAy9qwA@mail.gmail.com>
Subject: Re:ATM Visa card compensation, Thanks for your past effort
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Good Day,

This message may actually come to you as surprises today, To be very
honest with you, It is a joyful moment for me and my family right now,
so therefore am using this opportunity to inform you that have
successfully move to Vietnam where am currently living with my
business partner who assisted me to complete the transfer, but due to
the willingness and acceptance you showed during my pain have decided
to willingly compensated you and show my gratitude to you with these
sum of $950,000.00 Nine Hundred and fifty Thousand US Dollars).

I want you to accept this amount it=E2=80=99s from the bottom of my heart,
have issued the check and instructed the bank to roll the fund on a
master card for security reasons, you can use the card to withdraw
money from any ATM machine worldwide with a maximum of US$10,000 per
day. My bank account manager said you can receive the card and use it
anywhere in this global world.

 Go ahead contact the Global ATM Alliance directly with this below
information. Email Address:   maastercarddeptme20@yahoo.com

The Company Name: ........... ....... Global Alliance Burkina Faso
Company Address; ...... 01BP 23 Rue Des Grands Moulins.Ouagadougou, Burkina=
 Faso
Email Address: ..... [maastercarddeptme20@yahoo.com]
Name of Manager In charge: Mrs Zoure Gueratou

Presently, I am very busy here in Vietnam because of the investment
projects which I and my new partner are having at hand, I have given
instructions to the ATM Visa card office on your behalf to release the
ATM card which I gave to you as compensation. Therefore feel free and
get in touch with her and she will send the card and the pin code to
you in your location in order for you to start withdrawing the
compensation money without delay.

Let me know as soon you received the card together with the pin code.

Thank you
Yours Sincerely
Daniela Angelo Kyle
