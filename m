Return-Path: <linux-fsdevel+bounces-45431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE94BA7790D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B527A3988
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC181F130D;
	Tue,  1 Apr 2025 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYIBIHYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64842EACE
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504320; cv=none; b=mYZIpvuj+v9OE1oJPxFFstkn8pHUi0/GrieILC7q1zSVSQKq1SoZs4+aepfy8CSdU/UnS++KGh3kT4UIsg5l1uAKSTyEvrDfILjzl9iGea+b9ot2vBOT2zSLKnq1aVejsR3kam9xMANZ8q226G4M094LZzy5sSJm1tcpUS7RcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504320; c=relaxed/simple;
	bh=L3HDM/kODfVudTXxMFH9jIMDEr/alZVrsZLOUTzIUsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsoyeRXQgklTWBuNWHOu54Kb30IQiXjfYQWHVa+Dcr9h+yuzvULqi+ndsLGhDvTPYxUaIokeTb6LH4l6ds4rBbx8DUWCi9jfQeDCWYklS2eybskolvGaB/FswGb0769BXKHlsOlrYuEP5mqpu2PhP4DJZWhatjv++r6T65QB1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYIBIHYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61714C4CEE5;
	Tue,  1 Apr 2025 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743504317;
	bh=L3HDM/kODfVudTXxMFH9jIMDEr/alZVrsZLOUTzIUsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYIBIHYJ8eBlP7KQgKZ2fRZzbHKgmXjRr/9VLbUWlwjrvr9keChbZgsjZR6pRI9HS
	 OprHgUMv+eKtaV+zI+4cLa1eY0y5o16RdyEds1z/qq2tYR+ZmpZcA0WaSdXtQKAJOh
	 rF/59qli/gUruicmzJ6oSiQhcwwd0xIGGh4IGGkUX84yJ+c6vJwa0Uq6GSf5mdT9eQ
	 EBfaAkP1p/Z6Tl7409tvL1huzB/vTuVuKbUioZBWsC6o7hO0gOP+6xJ8FWKqrolM+j
	 I+PHdiQyFrbaHwQv+++rQIvZtaK9hN8W6YJ/oYI3yIEYZQKCJO/wpjWqoOUqFcYnDM
	 6zVBbLh1EPuCQ==
Date: Tue, 1 Apr 2025 12:45:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] [gs]etfsxattrat() followup patches
Message-ID: <20250401-pavian-wachleute-72a1fcc69d33@brauner>
References: <20250329143312.1350603-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250329143312.1350603-1-amir73il@gmail.com>

I'll do a review of the system calls and the extension here hopefully
this week and see where we're at. Sorry, I'm trying to catch up with a
bunch of stuff and the power management nerd snipe didn't help it...

