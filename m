Return-Path: <linux-fsdevel+bounces-74441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60155D3AC5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CDC431243FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363B38B7AA;
	Mon, 19 Jan 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmFJt6Mw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAC37C0FB;
	Mon, 19 Jan 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832804; cv=none; b=gG139AjZQZdCdKnCjbUWumvLEcIrPg5npY5QIMHV/r+XXGz7vnvaS11ohpA5LucxxjZ4XkIeVQmjppyHdireeFwj5n3eBnsNNPtZylRoQy+HemS5M8g9ktFSEhghuZOr/23uo5hCn608FmMZyjM0wlzgyGVVDRhVVFyoIccVcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832804; c=relaxed/simple;
	bh=zYgPbUIvOI/eIYcLAUkaAfmyJoWuvHhnUe5EkIKG3qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxOmlO0wc6ZCaVRezLgNN6hrmdfzNQymluKLAb31qk0oTA2W894oYMgToRfvgFeibcAvM40xR4NtVl9Q4FKBuXyTIOzosL+kbY3/t0JCw2VNFxqQukLcNBHLP7hwU0tee6RKtKd4hAiw/LbaKfmvvG8lgx6fpXnhszpNKQaOjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmFJt6Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4941C19424;
	Mon, 19 Jan 2026 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832804;
	bh=zYgPbUIvOI/eIYcLAUkaAfmyJoWuvHhnUe5EkIKG3qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmFJt6Mw/5KVucLHrqBHkKImBW4D9anZGrDzR7DQ0z+TfTHQjB/JLG3sij3qK0FDT
	 N9dTP1ieNYwddPogZcPsYykDCnziU7O/cKnIVud/yiOubFUoQVnYPmQJtItcrcPVZ2
	 P/NPA9bzvx5f1C5FnYmICbzEMk48qXwuD/JnZBKCqAtaL4Dc6+EE8G12Ghjif00rxL
	 jXxZBvWZ2LCJCPHmFOqiXxiUTtzP8JNcqMbjfILHZAVkRntiN9fvfNRetSN78bClse
	 HGsElR3adIdLZlThgAqzTg9R+F7H6RkuzWzJAZjLXe5ooCaCtj3cGfsNTp0zmSikOx
	 95itlDDyxK4LQ==
Date: Mon, 19 Jan 2026 15:26:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	lwn@lwn.net
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260119-bagger-desaster-e11c27458c49@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>

> (1) Fill out the following Google form to request attendance and
>     suggest any topics for discussion:
> 
>           https://forms.gle/hUgiEksr8CA1migCA
> 
>     If advance notice is required for visa applications, please point
>     that out in your proposal or request to attend, and submit the topic
>     as soon as possible.

Hey everyone,

This is a reminder to put in your invitation request for LSF/MM/BPF 2026!

The sooner you do this the easier it is for us to plan and the less time
we have to spend hunting down missing attendees just weeks prior to the
event. Unless you're really hankering for the special-snowflake
experience please do your part and get in your invitation request.

Please also don't forget to pester^wask^wremind your respective
organizations to consider sponsoring LSF/MM/BPF 2026.

Thanks!
Christian

