Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773983B09E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFVQGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 12:06:46 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVQGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:06:45 -0400
Received: from [192.168.1.155] ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MvryJ-1l5xgB2oKt-00srz7 for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun
 2021 18:04:28 +0200
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: struct file: what is f_version for ?
Message-ID: <f8370fc6-3cbd-4cec-fdea-edb8e5ba5215@metux.net>
Date:   Tue, 22 Jun 2021 18:04:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ARi23Gne/r+qoF75pLgiODHcfgGuMnHVQH0pKsYMehDvxBEPyQL
 AbpNg0187fFup0scAmteAJEOx7VNic+MWDxgwrdzJE9hj965SzkOAJ7PLIYYjH/xRulwFFz
 clagh0do8yxMAPPKPr4txz4JQDjWjamYlJ2QTJZZPHnvKNeenCfmi3nDZMLMIVRp8KUvdIQ
 Ib17DOeDegWPLq439eJKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vYWG7nmQ+uU=:D5yXdeaLAauLuwr7KhsuOL
 KTbnQYRtrlyuSZ4s/UfO6IST2OOC+H4hTMGJaw5uiwJ5ja0Lw1BXsH8IGbKkTfBFUdvhcauo1
 0w1dj/qJpljSAjWUVLDlmBMINNFi9NIqc4o1ZVliAGlpKpRcdsJa7zqIYukqM9f9/PVeS9LjD
 lbybWNo0lLcflesZAvbDqV+jI/8acJeZQBhDtnv6q+n0Gh0zXknQ8GZWoT0UPNWjT9KygS7rs
 8nZrcqbtQG5u71RKLxsZ1ALcVYvq7nuQFNjwpIT+Nqs9lszE866ECE8nv8uyugrm0TvbtBqsR
 5QX1Y+YAki33+tFmBWxs5y2LUmvCPK701LEWTiEbjNLRM5AcQ2PqE3wtPfGnk40lKBAsMd9NA
 G03sTuN+uGJcMhq9uZFGFcZy/X70NqMjeIsOmjzK9+da7kxpPoE6mkUImhHZpOIHLwPJjd8pj
 AuvoKwYy7Tdkqx8rP7D5FsZv9IKeVvpKotvoiXnQmpfoiTO5CSpW4b9TVcx0CVJUYr7ZPoCDo
 vivo7yebZ6G0NFhxWqmrEo=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello folks,


could anyone please help me what f_version field is actually for ?

I can only see it used in a few fs'es (mostly ext2 and pipes).


thanks,

--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
