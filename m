Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89D464DB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 13:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349209AbhLAMPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 07:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349257AbhLAMPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:15:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3332C061757
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Dec 2021 04:12:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so35359666edq.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Dec 2021 04:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=51mpXfg7k7qDketSblbwy3oymqbMO4GZFD8rTFCIIgQ=;
        b=PKkc5B6jLeeKIcJncE1YoVzTlALkVdER/l8/2+AJmPsTiw0unBYxZKt5ZUV2QA89PM
         dWqojWHu8pNS/SRTUQnDY/4Sf8+lACvn7+vf0XdHY3sCKDmOAkrZpT0MNVNEvfhJOoEM
         iL8iuyvgsQ0aompNGOgIVOcZ5oVXPRwsIdcuUhE/DCY5Y4fFL7WFownKP9PALyWM3stj
         kv6hduakhU+K6yb2njqz69q/RuRXcNkPiMsDm2JVLLgkXLrItfDM8y+CYKPHym6dWm5x
         hVnpxB6UzMGNof6Qt8yaplEBHo2LITfLViFWV2+owK6IbCY7PsOTC2//T8RAVoJCnZvc
         zJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=51mpXfg7k7qDketSblbwy3oymqbMO4GZFD8rTFCIIgQ=;
        b=2iyMtNINhMSoFrLQmPF3Z4lOVIbpr9uWQmrExmphUDeAJplCs2IuizmyE0+4nOR476
         Dao7/Niqmc7iYdNRIReWGl+9olLkQVimrKEZ84j42Nx1WogcRjf1EwIdvzVP2V5XehTy
         nFbFfWWyd4FC525qN5DsSl24LyFOTN+gnPYPj0Qycw+mZt0hleCc+ODK5eX9L20HFvbT
         U8F1EhvDe95Re5PGhsL3stj1L03bL/MGvIHCajz9sOBpVnFdvNI/XMu9x2rhJb83cEwR
         Dvy/0T4eE1/+sxUP29ScCQAPFg+FM1u+yW+AqzdECMNdfswVaG8bIQX9GkNnFXsRI1FQ
         5WhQ==
X-Gm-Message-State: AOAM533tqQtCRJRo27GhVxxjNMiu8jcS+s3xJoKkrXzRZug+j5M/XWMr
        d3RNlYfJlpcgudcNb7Y7YbBjzt396lMIOZtNsKo=
X-Google-Smtp-Source: ABdhPJwN14Nr2JCPKtRK7ou8m+v3AOgTXetQGnu9+UODv8J+w9H2lAF3AJgZXD1epj290xtwyhDua8xWsDpzZ6HwFzk=
X-Received: by 2002:a05:6402:34d:: with SMTP id r13mr8059401edw.208.1638360731131;
 Wed, 01 Dec 2021 04:12:11 -0800 (PST)
MIME-Version: 1.0
Sender: samco.chambers1988@gmail.com
Received: by 2002:a54:2106:0:0:0:0:0 with HTTP; Wed, 1 Dec 2021 04:12:10 -0800 (PST)
From:   Anderson Theresa <ndersontheresa.24@gmail.com>
Date:   Wed, 1 Dec 2021 04:12:10 -0800
X-Google-Sender-Auth: 3gRNLaIkm7LDYmNYvXUrsmZhgDU
Message-ID: <CACePhL=iKQU_UdwGwFdPv-0s2zEX9jx=Equ-U6FL3MJgLa=Fjw@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night without knowing if I may be alive to see the next day. I am
Mrs.Anderson Theresa, a widow suffering from a long time illness. I
have some funds I inherited from my late husband, the sum of
($11,000,000.00, Eleven Million Dollars) my Doctor told me recently
that I have serious sickness which is a cancer problem. What disturbs
me most is my stroke sickness. Having known my condition, I decided to
donate this fund to a good person that will utilize it the way I am
going to instruct herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
Mrs.Anderson Theresa,
