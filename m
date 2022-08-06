Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5862258B561
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiHFMYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 08:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiHFMYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:24:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0313210561;
        Sat,  6 Aug 2022 05:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659788631;
        bh=UovwDaLyuTgPejCzTK254N9IC9/vqRLIfV2J6pi3cos=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=a9fwassgbNp/eFsORC6vomzhKQDhM2K8+UJAIwEB9sRSM/3dzp1j7fyflsow33MYF
         81aazw3OzfsNl6ui8/QyG4e5LKsg7vYFTm4tOyYaRVdNpFBhk+REgBHtR4mBbH/8S9
         3Q9m7MENLt3DMs53shyio87/m3N1AzEI6lAz96U4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.170.46]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1oIePp13Oo-001li5; Sat, 06
 Aug 2022 14:23:51 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/3] x86/fault: Dump command line of faulting process to syslog
Date:   Sat,  6 Aug 2022 14:23:48 +0200
Message-Id: <20220806122348.82584-4-deller@gmx.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806122348.82584-1-deller@gmx.de>
References: <20220806122348.82584-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H01j2TQ/vI8Y6o0FFlkaFoyN427aLLFHAXOwrAp0nDGTiiV7Nq+
 uCJbOe9koCgQtLpU+9nuzPCG4KZT80QhBUZIcSt8TR3Db2qFjWxViCvSQwg8RhzhInCmpzZ
 eBUxsUKfOuB6yt9DaricIZfE20DESfPdSECZhDaFmcR9xcYAqzupvYwEa8fNw2k9cHRdiu5
 G0mvj5ArxQ84YO5uGzIjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZTF7NKTDIkg=:V5IrzQOrGpOVpaB+EZkEAm
 wsLFU0HPEtGwLzQNTX4xKiZVrc1MAly/s5sqMsqILOr1GFvamLJs5mrITSLnmv24tiC81ac4p
 PJ/QZfSZmyddGeoZ6JiL74GpJYtsZb+wOVukOtbI3l6NSjn1rhaxdkat1O4PrDMnfkOok1m2g
 t7HjwUnKCrg2TxT42zVGmIttLrMD35zURt/22hIuHHSPU/ZO1UVVaiD8j2h1GZAJhrZEy2Q38
 R1IVgO9JGkYa+xYEg5URMrIJ8KepjZ+b4GnyWuvHPTS2Bd452qBE/2qGeOfYJUmj+EZs21vQv
 vKmiTJLRVc9KrM24QR6tb+m0L5xRksLZw1GfIVqNShWcFsx2hgFWBslQ+lY8aCx0K3UScX2E6
 nPLZUSN7BQNWyQhRF+ayChwBRmVMWCGlIE4xZOuIoVLxOqoYn6ZrHRKchcWMwnPBCyHFt5Sxy
 WOj20gJYiCvysK3sOANSSLVlL1lU8Gvmi5ql7bIOTCOe5v1K5zHaDUbRoSl/p3VgaPXCGwJKp
 HfXXa9L67CHzXhnDKta84f1rAPDzwTdaGRTSOA/1iA3w+fTG0bIeQL7cDlRj0/Ali3uT0lXRq
 nejZq+kgx0lvL0h7dnk9vUiuVEfBmTNic7jE9hOcTNF27WV3P2pTQq4ZQrL6V519HQ2A5ER2g
 W0qWgOqqO+X0pD1zVoy0tpuR7vA5Mo+ZXAQzDdm/WeZRi4+NNFXIZUoZ2H8G1Htc3U3JTHLS/
 57Mq/4jVyjsG6ZNYGjxc9WdJI51M/QPFnvw0qQ3VF24l+YYrqSdvA4ssW4Xs4WB+nIp8AGpeC
 vUd+AR4Y9QtSwDwEkzQEvVWWEgbRpUUkPmbUpqlGwouTV/OoBwqSN2kVaJV+jVBBdjhcOz0h2
 dYotQtIWlRvztIDUBA0Rnlz8Y8dA60P+wMhJrMKVXrL7xWToL80BG5fM6h2FOkgxbPs3ShCrq
 rYV6VgQV5wbCshM5AMOnROdzeFIx2VVrDnaEcd+kADRRbeI8Btg7sEZdSCOZPyDGbCzYxwqIe
 4FWCjuAkbzgoKvVeR8djCtioKWsyhRFSjmzlANc/2lCLleM53lo2kXNjD5CyscAr37vMHgh5d
 mmzrgSNKS+PGv5ksMyyaCwp95m5BguKuzWtK1ksb3Xr3XftOpw1NtWW8Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a process segfaults, include the command line of the faulting process
in the syslog.

In the example below, the "crash" program (which simply writes zero to add=
ress 0)
was called with the parameters "this is a test":

 crash[2326]: segfault at 0 ip 0000561a7969c12e sp 00007ffe97a05630 error =
6 in crash[561a7969c000+1000]
 crash[2326] cmdline: ./crash this is a test
 Code: 68 ff ff ff c6 05 19 2f 00 00 01 5d c3 0f 1f 80 00 00 00 00 c3 0f 1=
f 80 00 00 00 00 e9 7b ff ff ff 55 48 89 e5 b8 00 00 00 00 <c7> 00 01 00 0=
0 00 b8 00 00 00 00 5d c3 0f 1f 44 00 00 41 57 4c 8d

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/x86/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fad8faa29d04..d4e21c402e29 100644
=2D-- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -784,6 +784,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long er=
ror_code,

 	printk(KERN_CONT "\n");

+	dump_stack_print_cmdline(loglvl);
+
 	show_opcodes(regs, loglvl);
 }

=2D-
2.37.1

