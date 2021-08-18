Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48703F03F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhHRMtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 08:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236106AbhHRMtN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B5D261076;
        Wed, 18 Aug 2021 12:48:37 +0000 (UTC)
Date:   Wed, 18 Aug 2021 14:48:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] exfat: allow access to paths with trailing dots
Message-ID: <20210818124835.pdlq25wf7wdn2x57@wittgenstein>
References: <20210818111123.19818-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818111123.19818-1-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:11:21PM +0200, David Disseldorp wrote:
> This patchset adds a new exfat "keeptail" mount option, which allows
> users to resolve paths carrying trailing period '.' characters.
> I'm not a huge fan of "keeptail" as an option name, but couldn't think
> of anything better.

I wouldn't use "period". The vfs uses "dot" and "dotdot" as seen in e.g.
LAST_DOT or LAST_DOTOT. Maybe "keep_last_dot"?

Christian
