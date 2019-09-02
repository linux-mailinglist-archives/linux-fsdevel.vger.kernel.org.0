Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5572EA5A34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfIBPKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:10:17 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:60584 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfIBPKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:10:17 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 8A02815CBF0;
        Tue,  3 Sep 2019 00:10:15 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x82FAE37021193
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 00:10:15 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x82FADHr022942
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 00:10:14 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x82FAD74022941;
        Tue, 3 Sep 2019 00:10:13 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Daniel Phillips <daniel@phunq.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        daye <daye@dddancer.com>
Subject: Re: [ANNOUNCE] Three things.
References: <8ccfa9b4-d76c-b25d-7eda-303d8faa0b79@phunq.net>
Date:   Tue, 03 Sep 2019 00:10:12 +0900
In-Reply-To: <8ccfa9b4-d76c-b25d-7eda-303d8faa0b79@phunq.net> (Daniel
        Phillips's message of "Thu, 29 Aug 2019 15:16:48 -0700")
Message-ID: <878sr6n38r.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Phillips <daniel@phunq.net> writes:

> Code for Tux3 is here:
>
>     https://github.com/OGAWAHirofumi/tux3/tree/hirofumi

It's old repo, actually the git repo of current code is,

    kernel
	https://github.com/OGAWAHirofumi/linux-tux3/tree/hirofumi
    userspace
	https://github.com/OGAWAHirofumi/linux-tux3/tree/hirofumi-user

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
