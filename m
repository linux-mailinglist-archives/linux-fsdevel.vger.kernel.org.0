Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE58B41FF3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 04:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhJCCtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 22:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJCCtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 22:49:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1383C061780
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Oct 2021 19:47:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n71so16322633iod.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Oct 2021 19:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/T9drlD1s9vO6lHEMs4LJzmDo2MKXEHBXvFYaWoQWpk=;
        b=pr+5UdCp6FVN3ayIp8PavfXN5zb/PZO+VwerYGrOc6sLN3ZoVK8vKBLlkrCVgvT/DO
         qeHmfUiLdDar9LYhRZjmrHxt3LaXAxiuJ+6fnjAq2RQnxuthjyql9fx+9wXhrbgrV+OH
         pjhIi4O9+KyKIcmikHsrqU7HLB4OBaTJKEDdEOV/7ft7k/VRl53qsApmILjyywst2xVy
         c5Bb2jcwMNV03ZfqsEarCEhOZ3dX5tWHnMRSxC5kg/k3l26WF0tehGLrZNkjbvMdcZd2
         vsiA78i/Yz1ifb8J3c+OgDBTouD5/tI6WLxAxeEtkKW44iZcbNAJfFx5ohT6EzTDctXG
         H2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/T9drlD1s9vO6lHEMs4LJzmDo2MKXEHBXvFYaWoQWpk=;
        b=diGDvPA7s+gpsDaRd3o052B6s+6Gej+1oFDwybOFO1b8pmrRsf+dWly5Iv6Jci0okw
         9YoLMx3KCujkX3J58tuE0oP30KENZq8cunvS6ScvWqceNfNeCDfDdcSOgL/NAPYzIijp
         F0mNBXk+Xm2W/x7Zt2HeuJgcUudFVyxMt21sTK8ZK8sUsNi/h27Nhcg1zXt3ZGr5JQfs
         WlnPqMiXKsrpVFwsh9Ipojc3RWrWHEBaO8wn2M49H9lyx7n9Qzay7h6Xg3q4IZPxwGyj
         eMjJPyZ90/XmBUNqFhuqx+eBxo7zKcLGfvhY0vVYGE2CbTALp3C/NA9Mxw06VnrfvJRD
         nXTw==
X-Gm-Message-State: AOAM530tCfWZslfuCNoVxiOm/vcx1Z93yTA3WTSjPldKkBse9jCcMOyr
        qEa0UeGeh/4C3vEisnV33kPwqxWwrh2lUePuF8A=
X-Google-Smtp-Source: ABdhPJyHwFxljeiJM9ull72OJnPTtelWaoQjJuwm8Zme2I/k9jzOEPXpCgYYr/5uYdMUjIyvgGDoegV0Zk1X908pdUE=
X-Received: by 2002:a5e:860b:: with SMTP id z11mr4297378ioj.145.1633229239681;
 Sat, 02 Oct 2021 19:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bf57:0:0:0:0:0 with HTTP; Sat, 2 Oct 2021 19:47:19 -0700 (PDT)
Reply-To: irenezakari88@gmail.com
From:   Irene Zakari <irenezakari44@gmail.com>
Date:   Sat, 2 Oct 2021 19:47:19 -0700
Message-ID: <CALwnxk=qihXmstj9BMSoVOmwC933C-eMREZWqfSU+6PoZrpekw@mail.gmail.com>
Subject: PLEASE I NEED YOUR HELP
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello   ..

How do you do over there? I hope you are doing well?

My name is Irene. (24 years), i am single, from Gambia, the only child
of late Eng. Bernard Bakary Zakaria. the Director of Bajam Enterprise
(Building Construction Company in The Gambia) also the CEO of Bernard
Import and Export (GAMBIA).

As a matter of fact my mother died when i was barely 4 years old
according to my late father and because of the type of love he had for
my mother made him to remain UN-married till he left the ghost..

So after the death of my father as a result of assassinate, his brother (My
Uncle) who is the purchasing and marketing sale manager of my late
fathers company named (Mr. James Tokunbo Oriade Zakaria) wanted to
convert all the properties and resources of my late father into his
which i quarreled with him and it made him to lay his anger on me to
the extent of hiring an assassins to kill me but to God be the glory i
succeeded by making a way to Burkina faso for my dear life.
Honestly i do live a fearful life even here in Burkina faso because of
those Assassins coming after me .

I would want to live and study in your country for my better future.
because my father same blood brother wanted to force me into undecided
marriage, just for me to leave my father home and went and live with
another man I never know as he want to occupied all my father home
and maybe to sold it as my father no longer alive, I'm the only child
daughter my father born, '' but he don't know that i am not
interesting in any of my father properties or early marriage for now,
because i still have future to think about and to focus on my studies
first as i was doing my first year in the University before the death
of my father.

Actually what I want to discuss with you is about my personal issue
concern funds my late father deposited in a bank outside my country,
worth $4.5 million united state dollars. i need your assistance to
receive and invest this funds in your country.

Please help me, I am sincere to you and I want to be member of your
family as well if you wouldn't mind to accept me and lead me to better
future in your country.

All the documents the bank issue to my father during time of deposit
is with me now.
I already notify the bank on phone about the death of my father and
they are surprise for the news and accept that my father is their good
customer.
I will be happy if this money can be invested in any business of your
choice and it will be under your control till i finished my education,
also I'm assuring you good relationship and I am ready to discuss the
amount of money to give you from this money for your help.

Therefore, I shall give you the bank contact and other necessary
information in my next email if you will only promise me that you will
not/never betray and disclosed this matter to anybody, because, this
money is the only hope i have for survival on earth since I have lost
my parents.

Moreover I have the FUND PLACEMENT CERTIFICATE and the DEATH
CERTIFICATE here with me, but before I give you further information, i
will like to know your full data

1. Full Name: ........................
2. Address: ..................
3. Nationality: ........... Sex................
4. Age:........... Date of Birth:................
5. Occupation:...................
.....
6. Phone: ........... Fax:.........................
7. State of Origin: .......Country:..............
8. Occupation:...................
................
9. Marital status........... E-mail address's: ............
10. Scan copy of your ID card or Driving License/Photo:............
DECLARATION:

so that i will be fully sure that i am not trusting the wrong person.
and it will also give me the mind to send you the bank contact for you
to communicate with them for more verification about this money. and
to know you more better.

Meanwhile, you can reach me through my pastor,his name is Pastor Paul
any time you call, tell him that you want to speak with me because
right now i am living in the church here in Burkina faso and i don't
want to stay here any longer,
send for me to speak with you his phone number is this(+226 75213646)

I will stop here and i will be waiting for your reply and feel free
ask any thing you want to know about me.
Please help me, I would be highly appreciated
Have nice day.
From Irene
