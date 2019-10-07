Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61319CEDC8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 22:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfJGUlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 16:41:46 -0400
Received: from ns1.tgtizmir.com ([217.116.196.59]:40154 "EHLO ns1.tgtizmir.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUlo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:41:44 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        by ns1.tgtizmir.com (Postfix) with SMTP id D2D2954D2AE;
        Mon,  7 Oct 2019 04:32:49 +0300 (+03)
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received-SPF: pass (ns1.tgtizmir.com: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dave@dbsoundfactory.com; helo=127.0.0.1;
Received: from [58.58.4.247] by 127.0.0.1 with ESMTP id 847C8D6DA6C; Mon, 07 Oct 2019 02:33:48 +0100
Message-ID: <t6$b472ku0980l0r0$373$r-$ip@4ef9zi.o.ojm>
From:   "Mr Barrister Hans Erich" <dave@dbsoundfactory.com>
Reply-To: "Mr Barrister Hans Erich" <dave@dbsoundfactory.com>
To:     linux@lists.openrisc.net
Subject: RE:PERSONAL LETTER FROM MRS RASHIA AMIRA
Date:   Mon, 07 Oct 19 02:33:48 GMT
X-Mailer: Microsoft Outlook, Build 10.0.2616
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="BB118ED_BAB2D5FF1EA50F"
X-Priority: 3
X-MSMail-Priority: Normal
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--BB118ED_BAB2D5FF1EA50F
Content-Type: text/plain;
Content-Transfer-Encoding: quoted-printable

Greetings

My name is Barrister Hans Erich.

I have a client who is interested to invest in your country, she is a well=
 known politician in her country and deserve a lucrative investment partne=
rship with you outside her country without any delay   Please can you mana=
ge such investment please Kindly reply for further details.

Your full names --------


Your urgent response will be appreciated

Thank you and God bless you.

Barrister Hans Erich

Yours sincerely,
Barrister Hans Erich
CONTACT: hanserich9helmut@gmail.com

--BB118ED_BAB2D5FF1EA50F--

