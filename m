Return-Path: <linux-fsdevel+bounces-55976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BAFB11311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C933E3B66E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B32EE971;
	Thu, 24 Jul 2025 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpVDTtmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0F2EE5F6;
	Thu, 24 Jul 2025 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392294; cv=none; b=RURQRrwDS5Jm5CFVlDNXvmYY+A1oz5TUymZJQdQ5k/VsbhRdsLWqQSkSRBCNJ1qE1fJzAm0jO9WMvew+cdkpPOanyzTxpkTtInm2pmgLTidRJxedZ02+obpWxGs5piD2s5sQXOvW73wfe2WRUXhjJKHIQejvIe+8z43xjya3P40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392294; c=relaxed/simple;
	bh=XF9wki9AjDCraP3PkW3hEqMnoy89UeAnuDiZvWolUoQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=d3h7yFYtudKxlIYIT99xRx3GXNSgmzHmglXoKvwae/qPhfbAJh4uLtN5jvmU8G07NHsM3vBuIhnHOmVEa9C4jWOnz05u/7BvhN8W6OsqdaaD87/6DYq/0P+UANe38vq+Cv6523qQvwW8J2e+Pbk0ai/8pjG/GW3XIL2A6wSjNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpVDTtmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D667CC4CEED;
	Thu, 24 Jul 2025 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392293;
	bh=XF9wki9AjDCraP3PkW3hEqMnoy89UeAnuDiZvWolUoQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TpVDTtmnke03qtUEM6XIe7WRETHGZba0w/dTkUEFESVK6kJkUu9ET7u/rEdgl4bGx
	 2EfRXLHH+i865D9SfrkseELWYD78ivz0BkiFnnzfeHYll1nkdAXSzp9qNT/KigbhAy
	 T5NiCU8nM+JrweBAZePm38tiRglzXSaeo6nE37mL1qsPw5wL8nRe1MxIARw6gt8vcQ
	 8sQUw65v/p2D0hPaA7kgvgfml9H9l59fExztLX1CwHYZM2Lu281UiO6W2v2a5oRSb7
	 sXmpIoxIWLKlTPQkXdbzWLZ3US4iGFhbInUbA7oANY0Ki5BVzlaTW/c4pyT0PuBrxO
	 eIxpilMnzjWcA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250625231053.1134589-2-florian.fainelli@broadcom.com>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com> <20250625231053.1134589-2-florian.fainelli@broadcom.com>
Subject: Re: [PATCH 01/16] MAINTAINERS: Include clk.py under COMMON CLK FRAMEWORK entry
From: Stephen Boyd <sboyd@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J. Wysocki <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Liam R. Howlett <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami T
 olvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Kent Overstreet <kent.overstreet@linux.dev>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>, Kuan-Ying Lee <kuan-ying.lee@canonical.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Etienne Buira <etienne.buira@free.fr>, Antonio Quartulli <antonio@mandelbit.com>, Illia Ostapyshyn <illia@yshyn.com>, linux-clk@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, kasan-dev@googlegroups.com, maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, linux-fsdevel@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2025 14:24:53 -0700
Message-ID: <175339229300.3513.16413844188162316683@lazor>
User-Agent: alot/0.11

Quoting Florian Fainelli (2025-06-25 16:10:38)
> Include the GDB scripts file under scripts/gdb/linux/clk.py under the
> COMMON CLK subsystem since it parses internal data structures that
> depend upon that subsystem.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Applied to clk-next

