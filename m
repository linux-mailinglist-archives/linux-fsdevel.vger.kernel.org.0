Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1C63CE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfGIUy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 16:54:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50582 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfGIUy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:54:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkx84-0002yj-RE; Tue, 09 Jul 2019 20:54:24 +0000
Date:   Tue, 9 Jul 2019 21:54:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] vfs: move_mount: reject moving kernel internal mounts
Message-ID: <20190709205424.GB17978@ZenIV.linux.org.uk>
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190701164536.GA202431@gmail.com>
 <20190701182239.GA17978@ZenIV.linux.org.uk>
 <20190702182258.GB110306@gmail.com>
 <20190709194001.GG641@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709194001.GG641@sol.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 12:40:01PM -0700, Eric Biggers wrote:
> On Tue, Jul 02, 2019 at 11:22:59AM -0700, Eric Biggers wrote:
> > 
> > Sure, but the new mount syscalls still need tests.  Where are the tests?
> > 
> 
> Still waiting for an answer to this question.

In samples/vfs/fsmount.c, IIRC, and that's not much of a test.
