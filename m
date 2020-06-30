Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3320EDDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgF3FwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgF3FwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:52:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A0C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 22:52:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so20970690ljg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=px4QvRdt/1sM0oVlZvtnuGXvJkNE2xZS+JuiLqaLkl4=;
        b=s4ZbVFunezaF1gFIvweGQoptAarmfPEOghKmwLVXCL8tYFtFBajLLjBpd/V/e7lu/x
         P2k93T5FHPISQwgcXh/d5YalN8QACtG38VclPMGdLhUbuXjtTuBYkbbHPUbnMoIHf9AZ
         cg84rhDt1KYCnViQZhEO5ToCTvfKn4dhW3+vGdNv3tTm8YRk+gTxIsjev43bFUTTIDpM
         ig6FHG2VcqpXG0+u0Er+i/tsOKj6Wc5bMIdj0qmhfYv2BQXDxo4qpE93jkvCthoCXsQB
         XF7sckcqPshdfPcg0m9O8EZKoOkp7WcCDzP1vI9Vzuc99ShZaGFOV444Fk2u+3aunWbX
         o3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=px4QvRdt/1sM0oVlZvtnuGXvJkNE2xZS+JuiLqaLkl4=;
        b=TmVHlK+kKOFTTS+zaFS8sHFlNh11NIqR4AJNTd01WZpOyN+atx/bozZlgISih8YdaL
         JrM1b9PoaCCrFNMa6R9ZeyIIQE1hXSgas5ccYNEvJfa4uBNQlBHTwQ1DUUnpIgmPjPco
         nSFYOy5oNBtvTv+vGXsKs49CfAjvJPZkC1+hJRD+neBWnD2cjTo2BnI/4Ywlj2EGcC9R
         2uicNq7VrTg9rFyJn2iHRDKcncQna+9LIjyc5d9Y0YSTf/ktXC2FRCpal5dfTR/LDL7P
         Pbmey8s8Y0eOzr2twub9c7Ja9PM0JEalviteiqzSenBP2DKJT07YRwqN9OCYEEPCF4jj
         o5Uw==
X-Gm-Message-State: AOAM533AtvuwF1cs10kVMLYGU0o05hidh2PgEZDmHXkfsiLROC6wYNaW
        A0OQBFxyp43Oak9KfTsCZFLyOQHdeMHFItU5fbI=
X-Google-Smtp-Source: ABdhPJwReMdY4Or4/KQYIohhNI9bUT95Wi1f6Ajr6QzznRpgYSHgfvijHQKvZEZ54UtdiXaosbm/U4mldIjlbk2ecDM=
X-Received: by 2002:a2e:a317:: with SMTP id l23mr10010089lje.175.1593496328557;
 Mon, 29 Jun 2020 22:52:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrshenritapieres1@gmail.com
Received: by 2002:ac2:5f0a:0:0:0:0:0 with HTTP; Mon, 29 Jun 2020 22:52:07
 -0700 (PDT)
From:   Henrita Pieres <piereshenrita61@gmail.com>
Date:   Mon, 29 Jun 2020 22:52:07 -0700
X-Google-Sender-Auth: dH77ruSQ-J7YIM7ZUhb0IMUI0FU
Message-ID: <CAEhvJqq=xp3sY6YKZ2ec5Ypj+Lan6Hodj1UKKHi=yGMOEs+Lng@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dear,

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise.  Actually, I came
across your E-mail from my personal search afterward I decided to
email you directly believing that you will be honest to fulfill my
final wish before i die. Meanwhile, I am Mrs. Henrita Pieres, 62 years
old, from France, and I am  suffering from a long time cancer and from
all indication my condition is really deteriorating as my doctors have
confirmed and courageously Advised me that I may not live beyond two
months from now for the reason that my tumor has reached a  critical
stage which has defiled all forms of medical treatment, As a matter of
fact, registered nurse by profession while my  husband was dealing on
Gold Dust and Gold Dory Bars till his sudden death the year 2018 then
I took over his business till date. In fact, at this moment I have a
deposit sum of four million five hundred thousand US dollars
[$4,500,000.00] with one of the leading bank but unfortunately I
cannot visit the bank since I=E2=80=99m critically sick and powerless to do
anything myself but my bank account officer advised me to assign any
of my trustworthy relative, friends or partner with authorization
letter to stand as the recipient of my money but sorrowfully I don=E2=80=99=
t
have any reliable relative and no child.

Therefore, I want you to receive the money and take 50% to take care
of yourself and family while 50% should be use basically  on
humanitarian purposes mostly to orphanages home, Motherless babies
home, less privileged and disable citizens and widows around the
world. And as soon as I receive your respond I shall send you the full
details with my pictures, banking records and with full contacts of my
banking institution to communicate them on the matter.

Hope to hear from you soon.
Yours Faithfully,
Mrs. Henrita Pieres
