Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43FC6392DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 01:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiKZAz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 19:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKZAz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:55:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54459146
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 16:55:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4507372wmo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 16:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLS2zcruSlKyOQ1OBKYSyr+7+6zj0YKBqr4fpDhq6DI=;
        b=Ka80aDwYnbIo4dAxEck7vtRMTcm0TV+2D5HG46fjjpZ1kAQB0Kq+jOwYDpEQN7dHIa
         ur2lz3ttU2JLJDzp+7KANzBndM9AYaoMdGIBqDgyA51pvU4V7tw4vDMf/dYqFh4fBfIf
         IrkfjI6A43LvLvGS18QZLyPjXRMPINFiGcS9EN+OCFhSYAg2RA8QF2DZNY/z7CgIYh6q
         q7r2KZ9D42HJMq/fLjvMQe11oemYPBKH2GeHEK3/Bx252mbQeCge3ZOyWe1PAwYGzVaR
         Tc0hcNRgnnaGErXo4z2zAzGZ3EQwld3JuR5ei3GQszFSukq8NFH2YlZMqrm+sv6noAgz
         x3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLS2zcruSlKyOQ1OBKYSyr+7+6zj0YKBqr4fpDhq6DI=;
        b=ExrsH6Ep9arebZVRsA3+V7SNBWPbJXdzIeQCnHk+n18toO1shAcMjDjoZkp2Rm978x
         hTj5wWenpAT+f77jwRW/19hOE8WYzl7agi0fAI7zzbpOvkbAmgKfHz1WgUxIsbLxZ8uo
         hBo2oQXPZctSKyKkpR0CTBv2aUMGEr/0C+u9VvaGHsFjsNbmkwwEndfajDrcZS4dlqeD
         IKnOtGEesMX6z+Axo/SPwd5CWoAWMIPF27Y6EPDK4N5yLK452FiHGK+cy7FmI2F685gs
         OTvkppuL1Gv3ivGY8DIOzb8RJOrWAUGRDXf/uXeqUp9OC5wwG9SQ9f6S7tQ/GUNwf5XQ
         VrLQ==
X-Gm-Message-State: ANoB5pmtSu2ax/jM0FPioRvxz/zgqlEZML4gWaogCF+UX2QJJNz4nzsR
        UBTq7VAaiFxB2AN1ZeE+ny7SABAbYU/9YFIFCXE=
X-Google-Smtp-Source: AA0mqf7GDbT0vOVsvjCAy0bzIAJGIrU+XHRqaWZ+7r7OOXCLeyrCybgo39iupmfrf0dlN/AAPME+cTvTlo9V3CDD4t0=
X-Received: by 2002:a05:600c:4b17:b0:3cf:8b22:b567 with SMTP id
 i23-20020a05600c4b1700b003cf8b22b567mr15915930wmp.144.1669424155229; Fri, 25
 Nov 2022 16:55:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:d1cf:0:0:0:0:0 with HTTP; Fri, 25 Nov 2022 16:55:54
 -0800 (PST)
Reply-To: samsonvichisunday@gmail.com
From:   Aminu Bello <aminuadamuvitaform@gmail.com>
Date:   Sat, 26 Nov 2022 01:55:54 +0100
Message-ID: <CADwEiSu9iJ3WMgNUA4hL7J6GkEeyOdfxqf6fDnOquFQuZaiSmg@mail.gmail.com>
Subject: INVITATION TO THE GREAT ILLUMINATI SOCIETY.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_LOAN,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5013]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aminuadamuvitaform[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
INVITATION TO THE GREAT ILLUMINATI SOCIETY
CONGRATULATIONS TO YOU....
You have been chosen among the people given the opportunity this
November to become rich and popular by joining the Great ILLUMINATI.
This is an open invitation for you to become part of the world's
biggest conglomerate and reach the peak of your career. a worthy goal
and motivation to reach those upper layers of the pyramid to become
one among the most Successful, Richest, Famous, Celebrated, Powerful
and most decorated Personalities in the World???
If you are interested, please respond to this message now with =E2=80=9CI
ACCEPT" and fill the below details to get the step to join the
Illuminati.
KINDLY FILL BELOW DETAILS AND RETURN NOW.....
Full names: ....................
Your Country: .................
State/ City: .............
Age: ....................
Marital status: ....................
Occupation: ....................
Monthly income: ....................
WhatsApp Number: ......
Postal Code: .....
Home / House Address: .....
NOTE: That you are not forced to join us, it is on your decision to
become part of the world's biggest conglomerate and reach the peak of
your career.
Distance is not a barrier.
