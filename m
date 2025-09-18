Return-Path: <linux-fsdevel+bounces-62133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1057B854F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9377C1DE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF695304985;
	Thu, 18 Sep 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TWipRitl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F968214204;
	Thu, 18 Sep 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206698; cv=none; b=i/X8mKvb4MUXjPqwFs3V05xEOzaFful4DnXS5Otg2LK8Pr/GFaphAWWCc+yfVMXr1Km+nZFg5QO52Qit+9JLafGtUkRMZAXHJpJ/b5QNz0Jt1k2NlQyOrsmvLowgsyP51esKlgKBel14oezUd+74A5H9JztOg0oN7A4b9p/pjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206698; c=relaxed/simple;
	bh=ek2nge1MskNZfYZzPvMcTh0zxUifVLLNrWvyeZC127o=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ne1FM25xNoUGbQ7wNM2CXqpghQuQPS+nLTCJYXKNDPgbIZW0ECO6jyxY7WF55gdR1PqEUo2ZsNkGWPSC4B1TIc8BWz2HQsFemqbNFloVeY6tykgLEruzbwaMh5rxcOSjgIYLOL4ZBz7D80wGuccjdNNnp6awRkqXfYoTshbkC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TWipRitl; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758206687; x=1758465887;
	bh=/wLoOln6eNSwukeEZdbQoBgwqheum+C2N0t3Nz3icdI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TWipRitlEGBBkOuiy/+Jx6mPIQ59Mrr11K1FXHMHAEkKQydUmZcp98XM3kkUzSt6M
	 Vhu7dtToAUc8GLqthuobqGJ7BaYyNioT3qmZkeWQvpLL4enZ0Hgs6xIQa2SGQz7+wo
	 3OoMdMpq0cQ/x4x2Ux/QxnGMGlJf9PMXLXanN8ts12EXV//BQb9wGi/dv52yHa9qkT
	 RiL8EV+UaTi5DaJaE5ze0vDyS0OMiwn5zFhDEWBjM4+Vv64o/bVAcQWgPZTSDQIaXQ
	 28RtEuH/ZL2OH652zUXlzaMXBHms8fgb2BhGsYj9ERfxZrOFDYAl0O8EN1MRBIEO+o
	 nROa/8GiS8AOg==
Date: Thu, 18 Sep 2025 14:44:43 +0000
To: "aliceryhl@google.com" <aliceryhl@google.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
From: ManeraKai <manerakai@protonmail.com>
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "manerakai@protonmail.com" <manerakai@protonmail.com>
Subject: [PATCH 0/3] rust: miscdevice: Extending the abstraction
Message-ID: <20250918144356.28585-1-manerakai@protonmail.com>
Feedback-ID: 38045798:user:proton
X-Pm-Message-ID: 40318d76600335c25d5fd2ac7676503b05546b1e
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The following patches are fairly simple, as this is my first time:

1. Introduced a new general abstraction called `FileOperations`.
2. Implemented `read` and `write` for misc.
3. Updated the sample file for misc.

ManeraKai (3):
  rust: miscdevice: Moved `MiscDevice` to a more general abstraction
  rust: miscdevice: Implemented `read` and `write`
  samples: rust: Updated the example using the Rust MiscDevice
    abstraction

 rust/kernel/fs.rs                 |   1 +
 rust/kernel/fs/file_operations.rs | 109 +++++++++++
 rust/kernel/miscdevice.rs         | 178 +++++++++---------
 samples/rust/rust_misc_device.rs  | 289 ++++++++++++++++++++----------
 4 files changed, 391 insertions(+), 186 deletions(-)
 create mode 100644 rust/kernel/fs/file_operations.rs

--=20
2.43.0



