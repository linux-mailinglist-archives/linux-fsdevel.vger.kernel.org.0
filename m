Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB957807C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 11:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358903AbjHRJCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358914AbjHRJB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:01:57 -0400
X-Greylist: delayed 1505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:35 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B03C30
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 02:01:35 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id B31F282418; Fri, 18 Aug 2023 09:15:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346552; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=UvQZ/HCKD1g3lo+fYd0/v00O1t5ekFHQYStVTdHGVZW9Xuw8etAMBgZukpaGO1L0v
         RAjQONulCzxRWKPgtXLbnYSOEcPdi+zHETeX9O8mgjR7ra4csarrURaJkjQyFt35HN
         jLPpDS5n1PiHzaUGgehk8G0L/5W3OzES64QW5uZy8lil6Fl3QUPm5eKrMdwrWFcSXD
         IjPNUVJ2qA2ARM76z/26pEVxXUsspS4WNnzYq9QDGYUw1F5DlP3+bPHoG+l6HCc7lR
         OjWJLAGOQig92InUnrDvvaKiE2rg+Q/486q/qDCiahN7loAj0iDDuhYBw50SeNy6BH
         +TNwvZdNCRxhw==
Received: by mail.leachkin.pl for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.ctnp.0.3b50pmflb9@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-fsdevel@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
