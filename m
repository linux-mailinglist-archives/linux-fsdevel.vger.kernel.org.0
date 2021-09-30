Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9541DF6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352267AbhI3QpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352193AbhI3QpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:45:07 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76518C06176A
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 09:43:24 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id b67so3146483vkb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/T9drlD1s9vO6lHEMs4LJzmDo2MKXEHBXvFYaWoQWpk=;
        b=RnPczgshY6Ea9Dh20LP4wm/elvAY3qgHmWeuGG6iiDJKrmEaFgQmVmSwpcjajHStQF
         LFMLUyoBVi9UkNEuAf1f/WpH4iaDX72kVYAllqh/vCF9F3S0r3gBdSmBLK3hdT51GcEs
         0JrvNV/ODqLNG4wdsW2RzkzeuIuPeyABBXyGedDXXzWgKNWo+BtVo5SAZtuWTO4wZhpv
         qub/KQUv46hIcAOkSjTI+k9iQu0t5gRUI7gY7g8BxRAj6hK5MHnDIboTCBJFMKcr+TLH
         nkRCLoIbcUjYWdkFrVmXxGFMmCQvwRHVuEprMDZ+uyutVQsOqcPW7tntP+Noj0GABzLu
         xHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/T9drlD1s9vO6lHEMs4LJzmDo2MKXEHBXvFYaWoQWpk=;
        b=6b350a1LaIqx/lNVMOMPl2mF1D8yKFPgyYQeJcjoU1t8LipGAF9WWWYGk2y+BN4AaC
         CVF5+3Ctbtryeu/3rEYBl5jBEfN5TYws15wYggD+FREwnX8dVsatKVZtisK7naWPhxgi
         hjUPpj5966lNKmX7pvZaDjaChcQKDIWvoREZZKqyPwB1Blc8jGaZIGbnehPmjx9m7/Za
         M3r2qd1EO/aFbErM6ByOfnKC/owGgnwkgIaradJRAMSRF4SjObGvS35ev28O1YK0oJhd
         Eh1dvkuhC9YIR3xRQbHnB7B1tjtrp9g74rpqOl+mpeJ/BRjTbZPMuDVIgMeWhuLkljOX
         9U0g==
X-Gm-Message-State: AOAM531fH6PTQTMvA/yEIEm135SzcYCdF8P/rqu7+2Bc7Cdrb04QJ7Ps
        pgToY9Bd1P5JQKRPl5yAzHZwVRTJdwAQqQXOLN4=
X-Google-Smtp-Source: ABdhPJwK18N5x0ZSKRCnZM8P+anMPjW8DLudkyLRzL8mw04/ZcjZ1bzLrV4qDHhaGiZQYpZPZj0oWIK2xMf2ef+KS3M=
X-Received: by 2002:a1f:ee0b:: with SMTP id m11mr4330134vkh.19.1633020203604;
 Thu, 30 Sep 2021 09:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:ab2e:0:b0:22d:7f44:603a with HTTP; Thu, 30 Sep 2021
 09:43:23 -0700 (PDT)
Reply-To: irenezakari24@gmail.com
From:   Irene zakari <irenezakari88@gmail.com>
Date:   Thu, 30 Sep 2021 09:43:23 -0700
Message-ID: <CAFT8PFFC1wYhu_V1nvdCu7SCx+WmhojOsdD9Ss5nWW_vtvA+kQ@mail.gmail.com>
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
