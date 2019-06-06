Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6937681
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfFFOYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 10:24:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51858 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728863AbfFFOYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:24:19 -0400
Received: (qmail 3059 invoked by uid 2102); 6 Jun 2019 10:24:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2019 10:24:18 -0400
Date:   Thu, 6 Jun 2019 10:24:18 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     David Howells <dhowells@redhat.com>
cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <raven@themaw.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
In-Reply-To: <155981420247.17513.18371208824032389940.stgit@warthog.procyon.org.uk>
Message-ID: <Pine.LNX.4.44L0.1906061020000.1641-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 Jun 2019, David Howells wrote:

> Add a USB subsystem notification mechanism whereby notifications about
> hardware events such as device connection, disconnection, reset and I/O
> errors, can be reported to a monitoring process asynchronously.

USB I/O errors covers an awfully large and vague field.  Do we really
want to include them?  I'm doubtful.

Alan Stern

