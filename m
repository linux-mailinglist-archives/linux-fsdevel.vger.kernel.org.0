Return-Path: <linux-fsdevel+bounces-6597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B23181A570
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536251C210C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85546427;
	Wed, 20 Dec 2023 16:40:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1841841;
	Wed, 20 Dec 2023 16:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94578C433C8;
	Wed, 20 Dec 2023 16:40:03 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:41:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ahelenia =?UTF-8?B?WmllbWlhxYRza2E=?=
 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RERESEND 04/11] tracing: tracing_buffers_splice_read:
 behave as-if non-blocking I/O
Message-ID: <20231220114104.2fa28766@gandalf.local.home>
In-Reply-To: <21b84f2e4e5eaad501ff7b2bb03e2ad2f25ecdf14.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
	<21b84f2e4e5eaad501ff7b2bb03e2ad2f25ecdf14.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 19:45:02 +0100
Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> wrote:

> Otherwise we risk sleeping with the pipe locked for indeterminate
> lengths of time.

This change log is really lacking.

Why is this an issue?

=20
> Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf=
5is2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u

The change log should not rely on any external links. Those are for
reference only. At a bare minimum, the change log should have a tl;dr;
summary of the issue. The change log itself should have enough information
to understand why this change is happening without the need to look at any
links.

-- Steve

