Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40985EBD09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 10:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiI0IRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 04:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0IRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:17:12 -0400
Received: from mail.ettrick.pl (mail.ettrick.pl [141.94.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0ED8E9A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 01:16:50 -0700 (PDT)
Received: by mail.ettrick.pl (Postfix, from userid 1002)
        id 5AD93A4C64; Tue, 27 Sep 2022 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ettrick.pl; s=mail;
        t=1664266607; bh=ChRcLNpIfKnVgp03/tSyWuRw1tWSTk/OEiEnuZMWs58=;
        h=Date:From:To:Subject:From;
        b=NG+C+yYLrFHQz73SXXH2O+u/BhH/RUfy78ldjMnCwHUaevjYwTFbcf+qIjMLIWuzv
         EmldeYkAVYHmV595fEyPmw5wA66TvJQC0HhujceVbQgCOfw/t32XifpBCjq8DFAlGJ
         bgrm8goNGI9qUFts9jwEN0JozY52HYuxmvzUOk6bi/T7QcmxPvdyBve/U2XoM9rhvm
         Fu/H9L9gdQt8riJdF4/gWLZ2SPQb/RUHzP4GADqly6xsLaQ+/IA/mYchaK8UjA6nNm
         N88c7ATTyZ5OmjnqHhHLN3AFAybmMdk9jSF1FvBiYLKFkZOSOSzSZoMazwSYN5Sa04
         1z+a2KlLOFXJQ==
Received: by mail.ettrick.pl for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 08:16:13 GMT
Message-ID: <20220927064500-0.1.62.18r8k.0.m42z44qbtc@ettrick.pl>
Date:   Tue, 27 Sep 2022 08:16:13 GMT
From:   "Norbert Karecki" <norbert.karecki@ettrick.pl>
To:     <linux-fsdevel@vger.kernel.org>
Subject: Wycena paneli fotowoltaicznych
X-Mailer: mail.ettrick.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A,
        URIBL_DBL_SPAM,URIBL_SBL_A autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: ettrick.pl]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [141.94.21.111 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [141.94.21.111 listed in bl.score.senderscore.com]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: ettrick.pl]
        *  0.1 URIBL_SBL_A Contains URL's A record listed in the Spamhaus SBL
        *      blocklist
        *      [URIs: ettrick.pl]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dzie=C5=84 dobry,

dostrzegam mo=C5=BCliwo=C5=9B=C4=87 wsp=C3=B3=C5=82pracy z Pa=C5=84stwa f=
irm=C4=85.

=C5=9Awiadczymy kompleksow=C4=85 obs=C5=82ug=C4=99 inwestycji w fotowolta=
ik=C4=99, kt=C3=B3ra obni=C5=BCa koszty energii elektrycznej nawet o 90%.

Czy s=C4=85 Pa=C5=84stwo zainteresowani weryfikacj=C4=85 wst=C4=99pnych p=
ropozycji?


Pozdrawiam,
Norbert Karecki
