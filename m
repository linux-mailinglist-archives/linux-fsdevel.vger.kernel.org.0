Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093664C90F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 17:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiCAQ46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 11:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiCAQ45 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:56:57 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0AB62EA;
        Tue,  1 Mar 2022 08:56:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a23so32736856eju.3;
        Tue, 01 Mar 2022 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=GDnZ8hNkIvcq50bCWCBGSUGNF9aGLbOlF2BISXEvTIc=;
        b=XZHXrDVIuoc9YBQu969pl25pwdzYDhxDjORc66mDlrDLxp3p/E7LROWrLoiFlLJj+W
         KOzYnunNATLurMoRb8PL0SM9JQcH8CP4gb63oZ2VGjuhqwXNt0ZxZMZCiWxbPA/vTiWV
         hgNVZMi9xxZ9GHNW/BmuHMLBcUmarYuLSytvHPhvgHXuW4vYA48CnaO7dZBSpverGdTm
         T+0CjLk9uGVoR0TQamqSQKjjDPZHdKxiopJydVu559lgSSC4Nv+NHu64xVEeqS6naHxG
         Pa5hjsrsFoVH4FqA3jj1XG2hRHivAFy6MXohghx53w3fIyxzm4CTy8vkIy3/aXvLNXs+
         JFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=GDnZ8hNkIvcq50bCWCBGSUGNF9aGLbOlF2BISXEvTIc=;
        b=GpdocEH5Li0JAlUTZnquzhrB7yopHsPYQC6lS/TZgO2PDpbNP9cNnd3JQ1XAKUjw22
         lXQ6ymnS0emzExMqsbRftATRXePftdaKx1P+6+Jj/arkJ1lwtP6qeLfd2c/BDpZazBQX
         2JsxoKjGmPNld7D/F7mZ6RiGaLI4MM5qRjIsZb3HD8mV/I/KhrwkrhSoWVEw8vBu8xuX
         /p23NbQ5JXbRajHxDUQtUntW5aNMAI7BuKhBhzZEe9FxPelvczZdPeAlTgc6j9y4zB7A
         tpiWzinhH/GzOW60IPI24QGtUbD0iuiAFmJ8LwJSzTqGtCrqfra5YI8ufBRuokzZxNyg
         shwg==
X-Gm-Message-State: AOAM532TVGS0WHzhhVFI1HKssvNTYy/CGt1SA1/oSqhLRQAUjUVLPm0K
        5Cqc/+mUrjRgmbseWIvve3s=
X-Google-Smtp-Source: ABdhPJzA4fcwHjzfdODfd5XwBOCEAq7WKV2kGsde3uQyxlrmsT+bMEhidcy2gAFaCIFJM0aaK8yIOQ==
X-Received: by 2002:a17:906:7c42:b0:6d6:da70:dfa with SMTP id g2-20020a1709067c4200b006d6da700dfamr5198300ejp.3.1646153772393;
        Tue, 01 Mar 2022 08:56:12 -0800 (PST)
Received: from [192.168.1.103] ([129.205.124.14])
        by smtp.gmail.com with ESMTPSA id ee21-20020a056402291500b00410d4261313sm7303840edb.24.2022.03.01.08.56.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2022 08:56:08 -0800 (PST)
Message-ID: <621e5028.1c69fb81.cf6a6.9235@mx.google.com>
From:   Phillip Chippewa <katatimar552@gmail.com>
X-Google-Original-From: Phillip Chippewa" <info@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ahoj
To:     Recipients <Phillip@vger.kernel.org>
Date:   Tue, 01 Mar 2022 17:55:55 +0100
Reply-To: chippewap887@gmail.com
X-Antivirus: Avast (VPS 220301-2, 3/1/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ahoj,Som Phillip Chippewa, mal som to =C5=A1tastie, =C5=BEe som z turnaja v=
yhral jackpot Powerball v hodnote 80 mili=C3=B3nov eurMichigan Lottery, Gra=
tulujeme, v=C3=A1=C5=A1 e-mail z=C3=ADskal dar vo v=C3=BD=C5=A1ke 2 500 000=
,00 EUR. Kontaktujte ma kv=C3=B4li reklam=C3=A1cii.

-- 
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

