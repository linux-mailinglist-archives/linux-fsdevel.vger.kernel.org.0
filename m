Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E422ABC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfEZTGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 15:06:40 -0400
Received: from mail02-md.ns.itscom.net ([175.177.155.112]:43453 "EHLO
        mail02-md.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEZTGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 15:06:40 -0400
Received: from cmsa02-mds.s.noc.itscom.net (cmsa02-md.ns.itscom.net [175.177.0.92])
        by mail02-md-outgoing.ns.itscom.net (Postfix) with ESMTP id 4F32DB0068B;
        Mon, 27 May 2019 04:06:39 +0900 (JST)
Received: from jromail.nowhere ([219.110.50.76])
        by cmsa-md with ESMTP
        id UyTfhOMNFRqYFUyTfhth0V; Mon, 27 May 2019 04:06:39 +0900
Received: from jro by jrobl id 1hUyTe-0003tD-JL ; Mon, 27 May 2019 04:06:38 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] concrete /proc/mounts
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kolyshkin@gmail.com
In-Reply-To: <20190526120719.GQ17978@ZenIV.linux.org.uk>
References: <17910.1558861894@jrobl> <20190526120719.GQ17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14953.1558897598.1@jrobl>
Date:   Mon, 27 May 2019 04:06:38 +0900
Message-ID: <14954.1558897598@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro:
> Translation: let's generate the entire contents on the first read() and keep
> it until the sucker's closed; that way userland wont' see anything changing
> under it.  Oh, wait...
>
> NAK.

Do you mean that the change can hide other mountpoints which are
kept unchanged before/after read()?


J. R. Okajima
