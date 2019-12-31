Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA08D12D944
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfLaNwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:52:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43280 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfLaNwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:52:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so13963722oth.10;
        Tue, 31 Dec 2019 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vSo7IfXeXlI4PJBgCfExx/1fJqgzCNl6+2Ev266b01U=;
        b=CiQFZ0756aQVHqVC4nx7R0fcdpFjj4wTLDncEQvyUCFu4WYbi0I9Yr9VwRAN8Gkwhq
         bY5ifBr2EFLPe3pGHk90IWkgs2nHmDuPQVk0MVNjol90TJkOaqFy9UfbO0NvytBttOiZ
         POEwN1OB6uutyGymuxGJQyP495AkJE6qoFG7DkNB1aTiO4Jlbwb5JiJJul7m2lemrPAM
         0BxQjFlmdZ+Z84ENmTckHpROmWoPaZgJMutc+vTo0uNolOuhuefPrrHv8WCeUE+Zjo3i
         tXgobeQnhsunZ8BJSgHJkg9oZf4nM6oy3OqEHIiApgYidmMv4pssF3cfMDTSYYQqfklc
         ii2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vSo7IfXeXlI4PJBgCfExx/1fJqgzCNl6+2Ev266b01U=;
        b=l6PKRAoevDD1/GxPAfe72ZqUdEGa8aZ6V8agjsjl5SJ9KmzcaNTY9c4GFQmCsiQLD6
         GGv9hpoNtnjxaufVeMBrS593F4WCFaxxDYmEeCHruysvzAO0nY7r7ds/FgjQx1Y0UPKl
         fJrFRrpnDit8w6/vuBuCN/yUBXlQ++oVSup0oA9knaNE5aLRMAlYuUi573pqkb7+dMfj
         bL5+ajlOwm5XJ57oMeoIdUSZfR5n6RkCh6kA8M72qA6UH3pCYAsq0KWeDfN0cL56nbQ3
         na8PEaVRMG9jbMDuC8gijcUUlG2OFb71sFEb/YRNx4xEpuKdPl4aX84bRZbxduGFtjlU
         /liQ==
X-Gm-Message-State: APjAAAUVUVpqho2kkqDkL10bIEfswHyMazbSngIYbTg6wnUAG/peN71Y
        wqNn00cDysJoypJH6jaCbgfYglRHjhMLbaggUmHAjw==
X-Google-Smtp-Source: APXvYqzN1Y4T5LVzomKrfJTcBraUBS/uJX22HStq1S45hJZVhkP0+pSnoQ+V+lSFl/S8R4n0qNfBspD9LElVtaNh+KI=
X-Received: by 2002:a9d:6196:: with SMTP id g22mr83247505otk.204.1577800358015;
 Tue, 31 Dec 2019 05:52:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 05:52:37 -0800 (PST)
In-Reply-To: <20191229142340.sr2xbmwlczb2ytjj@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062736epcas1p3c58bf86018ba9caef90b3a6476b4b925@epcas1p3.samsung.com>
 <20191220062419.23516-9-namjae.jeon@samsung.com> <20191229142340.sr2xbmwlczb2ytjj@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Tue, 31 Dec 2019 22:52:37 +0900
Message-ID: <CAKYAXd8Ed18OYYrEgwpDZooNdmsKwFqakGhTyLUgjgfQK39NpQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/13] exfat: add exfat cache
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2019-12-29 23:23 GMT+09:00, Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> Hello! This patch looks like a copy-pase of fat cache implementation.
> It is possible to avoid duplicating code?
I am planning to change to share stuff included cache with fat after
exfat upstream.

Thanks!
