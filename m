Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A76B7676F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 22:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjG1UYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjG1UYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:24:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145244483
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:24:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fba86f069bso4341213e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690575840; x=1691180640;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SyWx051AYSsya+pzm/2CESWC0aQN46Y6mRWxZ4kl/fY=;
        b=Qw3w7VO9HrvKSKyD7H4huWlE3nW3m3eltH13wxk4zWtSaAeOl1KW/ha8G45LRlWsP8
         ZVZD0DlOSeakHF5ktGw7Vl+sHBemleXnFAdJAH/eyq7354mugbfdiQ+NqYo9Iab5Mh/g
         Vo9hcPOpODLPDOWr3lIjl/0sr78gOP0ZJ9oZ1W1/v/ZOmyqjLyOuyVsXowVMAYhE+NEp
         tlFnQoXXGpuCdatHVinyw78/tGP6yypqPyyQbA3iWSOOFIpS/ViXD5eyi2bw9w+K1gA4
         J/4pLa/cLgKep6vRGKhAEN3osp7ox8UEfofMgGaP4vGS0sq/6MuPqbGRfCdm0YlBO6Ft
         fcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575840; x=1691180640;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyWx051AYSsya+pzm/2CESWC0aQN46Y6mRWxZ4kl/fY=;
        b=b2ceoAxi14vh7CPU7Jgt0lKGc9YVwBVP/eUf5Axp05M8KXPrtan7hn7MWMmbgyaqNy
         LcQEojjOXB41yYMMc6qxip9Gjusat1SuNrryXihRonMxTpokCHx78ZGVZTtqV7tp7v1I
         yP+iuZZi0PGKGvHq6okvebz/AVsOKHcwikxGvqi5ibmnap+eK27tt14vcXDk9D5Px3Z6
         v2lzpEH+pFocHzwSclmUGZnO5R7Vz607saUU+YJ6tPmKBJXtVKQplxjUPHfd7E/P6/No
         CNL3K9Nxblds1oU1029QWfAf2N8HnCDMrmsMKKL18BTv0LYj8yfNDcaWAZ5iGVSy9NIs
         SJ0A==
X-Gm-Message-State: ABy/qLZO/JjJQCnAHMJ1Z8l3ZbzvSmXQo2GL/fLkDY+gHD8x9ki0xOdT
        6aydZAfVcpwGaVxshLEWrguCgixnZ/hHFp2pCjc=
X-Google-Smtp-Source: APBJJlE80BBukWTjizwSVjuE9FUl7cpfBxKsnWfRQ1oQKqApf+0H9nBeN3zt9vUi7aZtPlEIJgF+/+xsaDafHdQaMaI=
X-Received: by 2002:a05:6512:55a:b0:4fe:1f27:8856 with SMTP id
 h26-20020a056512055a00b004fe1f278856mr2526997lfl.7.1690575839989; Fri, 28 Jul
 2023 13:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:c6d2:0:b0:51e:1856:95ca with HTTP; Fri, 28 Jul 2023
 13:23:59 -0700 (PDT)
Reply-To: mrsmadinadina@gmail.com
From:   MADINA DINA <dmadinadina@gmail.com>
Date:   Fri, 28 Jul 2023 21:23:59 +0100
Message-ID: <CAFNMNTgYeh-1vnOR991GYboj0UzEZVmCPwPo9zB5CZZomeQFZw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:132 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dmadinadina[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Hello beloved,

I am Mrs Madina Dina, I am a sick woman who was diagnosed with cancer six
years ago. My main reason for contacting you is because I want to entrust a
charity project to you, I know this may sound so strange to you and also
extremely risky for me to offer such a proposal to a total stranger via
email but this is my last resort to get this done. I am looking for a
confidant, someone to help fulfill my last wish. Hope to read from you. I
will appreciate your selfless act towards the less privileged, I don=E2=80=
=99t mind
if you could be of trustful help. I will be waiting to read from you
urgently as time is of essence due the limited time I have and my ill
health condition.
