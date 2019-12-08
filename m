Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03C116104
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 06:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfLHFy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 00:54:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLHFy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:54:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idpWF-0003DG-ST; Sun, 08 Dec 2019 05:54:16 +0000
Date:   Sun, 8 Dec 2019 05:54:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: make rename_lock per-sb
Message-ID: <20191208055411.GT4203@ZenIV.linux.org.uk>
References: <20191128154858.GA16668@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128154858.GA16668@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 28, 2019 at 04:48:58PM +0100, Miklos Szeredi wrote:

> Turning rename_lock into a per-sb lock mitigates the above issues.

... and completely fucks d_lookup(), since false negative can be
caused by rename of *ANYTHING* you've encountered while walking
a hash chain.

NAK.
