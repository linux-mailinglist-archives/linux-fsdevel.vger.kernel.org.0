Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2344D67F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 13:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhKKMVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 07:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhKKMVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:21:31 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BCC061767
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 04:18:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u74so11201916oie.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 04:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=LjD4GxWdc2zr8/9EZOl5q2FS3VyqZrhxuRWYjSCst2U=;
        b=FAcAHuisRDxu1XfnQzmstT7yhkhyxPHeK9K6IE90u6wr9ObYiguSKOf2/O/hY8wb4f
         HCqWbr/LEyCLPOk1c9s1uRbSBdlPj4NKnE6n3lO7wNYR0IUcXiHw+uP5xDD+l+AzMsaG
         8gtaUO/7Bcf806zv1cYjagdlZT8Nxu541yLTDhtW2oZA8fjUhK+MLE8gDpXMC6V2ko9v
         cVJ0MV0h65gBt3mxDZhO5V3qFHGHeYOJNdV4ZAsEfaWxtZ3JR9s7GIjWdbB8g5fRuKpB
         JmHXIsAO3FsrQPnf9zcYXTvrAT9PFZqQ+Y0lgxk196Sg7Fd70ApbT/G6SjG6LxVwPBqX
         zf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=LjD4GxWdc2zr8/9EZOl5q2FS3VyqZrhxuRWYjSCst2U=;
        b=cBEUJgFq9a71WokWK9ISz951bsKuRq4vgENTwTIs4K8JU7rY/xgnGD62BS1wLM94h+
         3QOzCSgq+APZCxlynCPXZ6bvS4INHALJVShuX2NEvhvks/nHaYGNXIrAMm0J7hFbteUX
         Lj+bmiUsEfN1S/goZxCquvpsmc4Aa7ehZUV7FIq255lk7TSzBGZxjzcXlEcEw5wdndWU
         R0m+2BFg72ZRdcN9rpipJMJsm/wRTfZhzpV4sHr+9kX8tXfWElcnpSeBaB9BuuIDpUH/
         ORm5PcH5RTFnv+igELb1qaVzuMT7K7FLO44ckAs/keEUkImrEQZn7ugg+KT3kBNlOiV7
         B5MA==
X-Gm-Message-State: AOAM531wB85sJmqq+H7Xh9PzloSOEQ+7s40appCLQtTMKa9JTI3Wrjpr
        l8VRxPtwY5OCEIB9Ara43P4pPgTavYhSiWv+0vA=
X-Google-Smtp-Source: ABdhPJxgZP5ZbLG6fgHoEtSuJgJQQqH1uRM/DdmgsytiDRlBhSQwW27n8QF8El0ZuL5tj3Rqwu3A70qeq9mmY45QQLM=
X-Received: by 2002:aca:be54:: with SMTP id o81mr19026897oif.64.1636633121948;
 Thu, 11 Nov 2021 04:18:41 -0800 (PST)
MIME-Version: 1.0
Sender: wm8888888@gmail.com
Received: by 2002:a05:6838:9d41:0:0:0:0 with HTTP; Thu, 11 Nov 2021 04:18:41
 -0800 (PST)
From:   Mrs Carlsen Monika <carlsen.monika@gmail.com>
Date:   Thu, 11 Nov 2021 13:18:41 +0100
X-Google-Sender-Auth: G--wb6VUHTHR7VUZV9ibep0zJBk
Message-ID: <CAE5if2Oea-H=0RA9xfwGEjFJH9jcpXH3B6hG1FSVKVv-z1TAnA@mail.gmail.com>
Subject: Hello my dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 I sent this mail praying it will found you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day.I'm Mrs.Monika John Carlsen, wife of late Mr John Carlsen, a
widow suffering from long time illness.i have some funds i inherited
from my late husband, the sum of (elevenmilliondollars) my Doctor told
me recently that I have serious sickness which is cancer problem. What
disturbs me most is my stroke sickness.Having known my condition,I
decided to donate this fund to a good person that will utilize it the
way i am going to instruct herein.I need a very honest and God fearing
person who can claim this money and use it for Charity works,for
orphanages,widows and also build schools for less privileges that will
be named after my late husband if possible and to promote the word of
God and the effort that the house of God is maintained.

I do not want a situation where this money will be used in an ungodly
manner.That's why I'm taking this decision. I'm not afraid of death so
I know where I'm going.I accept this decision because I do not have
any child who will inherit this money after I die. Please I want your
sincerely and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account.I'm waiting for your reply.

Best Regards,
Mrs. Monika John Carlsen
