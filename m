Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0AB5555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfIQSad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 14:30:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47650 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfIQSad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:30:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAIFB-0002af-Tt; Tue, 17 Sep 2019 18:30:30 +0000
Date:   Tue, 17 Sep 2019 19:30:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] init/do_mounts.c: add virtiofs root fs support
Message-ID: <20190917183029.GH1131@ZenIV.linux.org.uk>
References: <20190906100324.8492-1-stefanha@redhat.com>
 <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
 <20190909070039.GB13708@stefanha-x1.localdomain>
 <CAFLxGvw51qeifCLwhV-8DKXNwC9=_5hFf==e7h4YCvFE5_Wz0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvw51qeifCLwhV-8DKXNwC9=_5hFf==e7h4YCvFE5_Wz0A@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 08:19:55PM +0200, Richard Weinberger wrote:

> mtd, ubi, virtiofs and 9p have one thing in common, they are not block devices.
> What about a new miscroot= kernel parameter?

How about something like xfs!sda5 or nfs!foo.local.net/bar, etc.?  With
ubi et.al. covered by the same syntax...
