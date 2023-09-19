Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760917A5B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjISHjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjISHin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:38:43 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:38:35 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1C8CD4
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 00:38:35 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 6B4B976129F; Tue, 19 Sep 2023 09:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108678; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=q33R6DwrFOFtulVNDXD9FqeBfbeNj4tCffGjwLkfw2NiwcR5rcQSYrft8LpdqI4fe
         9Xf9Iyk9MJq/uwoqnrz3Z9h812uyEXQsmXbRHoQ2ff1XXZE8c+9+9vUKj9iIWR5WG5
         1S2AFCrBeYVtfR81C1EptEIfmLarPYPc2/7F9YUk+p2TGNuSTgM3NRKsDNj/lXWUa2
         l+LflIhzBO3OpSNz1q6QkxAyTiwZWtIWvgxbcTsKocWw/YQK1vnd0jh0lgDO7Q1LSX
         G9J4Wx59cRU1030of/w9ecZsxz3UeA/Jq6HHLGKMhBDNHEWQRwr5xazywEdESiB5mh
         q2sfjGrf4szCQ==
Received: by mail.leeswilly.pl for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 07:30:18 GMT
Message-ID: <20230919084500-0.1.3z.bc35.0.le1r6yeb72@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:30:18 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-fsdevel@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_DUL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak
