Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00162823
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbfGHSNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:13:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60592 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfGHSNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:13:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkY8V-0003vz-Um; Mon, 08 Jul 2019 18:13:12 +0000
Date:   Mon, 8 Jul 2019 19:13:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
Message-ID: <20190708181311.GW17978@ZenIV.linux.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708180132.GU17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 07:01:32PM +0100, Al Viro wrote:

> Right now anyone relying upon DAC enforced for MS_MOVE has worse problems

That'd be MAC, of course.  Sorry.
