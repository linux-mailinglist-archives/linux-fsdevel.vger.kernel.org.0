Return-Path: <linux-fsdevel+bounces-16250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6889A8E9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 06:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A478D283627
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C51CF9A;
	Sat,  6 Apr 2024 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KQt2BQQh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73D139F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379386; cv=none; b=kb7/LxvYeCF7sXlmWS3tFmKp7m/nb1JhLuunlLJqgiXVdXRTGMToyt7gIMTzu5OEYOVKU6Pk20EZUpKzC3YlkJRdum1C58l2Yt5ezlWzSh5W3mQ2wFBdw9K5/Wfc9XmFUlYovEC/gBb/pUglHRIW9Ku+Y125NGKJqRJEBJf9+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379386; c=relaxed/simple;
	bh=Qiy+w21Pe4ai721H36YCIqspzoHaWuJMrOJvxU9bgXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GD+kssZDzB0eWyDgNxZZIzEnvee3a2QqofWhi3+P8M9zVXoGhxcBu3A04mRK/U1w6zxdAwaAiDaKBbDG1myRbV09Ei05zXnuO5B0evK5J1oT6e3fSGvQCMzzLsn5zb040bcu6Ie3VSUvqDtm3jF1LMjdvfddFI7A3bwn2KHz36o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KQt2BQQh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8FwbeLX8YEPXfUOaA7V7UN1LcIpDsm6d11r2C4pPkuk=; b=KQt2BQQhyi4Smc19OmxoeVpJNE
	JUdb9LI0JKQvMUL9ED3fcN0aU+JDxYeJDtqTCPxqp00qAQNXGHA+LqPBES8sDWb8ypS8L3yQu3pi6
	WRBZmyr1Kp6jCjLqR99V7Fxw5VIBFU1veo9VXaS2G3gD09yWDZwl6nptArXU2VoKjCroE0Uo26gM7
	nYjNegNa/MUn3vN3gxhYDGlVOmazx3/LrUAZ2pbFHfTehfcMoJaI8SFhGTXh2P/pFqrYZySALW89F
	FILhxQ3QWJBXp6z3dAmEiNCGa01FYm+pe5hX1zbdZzED1HGi7Hb3o7xoBtidcIwCC3LYK6YQqtAdN
	MGZvFbaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsy6I-006qfF-0U;
	Sat, 06 Apr 2024 04:56:22 +0000
Date: Sat, 6 Apr 2024 05:56:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCHES] misc stuff that should've been pushed in the last window
Message-ID: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Several patches that missed for-next (some - for more than
one cycle).  This stuff is in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.misc
and if nobody objects, to -next it goes.  Not going to be rebased...

Individual patches in followups.  Please, review.

3 descriptor-related cleanups, then a couple of patches
eliminating 'inode' argument of kernel_file_open() and
do_dentry_open() resp., then Miklos' removal of
call_{read,write}_iter() from back last August.

