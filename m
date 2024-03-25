Return-Path: <linux-fsdevel+bounces-15205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAC88A596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD45930906A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8D14BF93;
	Mon, 25 Mar 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN3DFbFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750E156964;
	Mon, 25 Mar 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368117; cv=none; b=pjcQYg3zEBSX+siro2jKVsk4yfXf/Bl4OzdvmbemzpSpK8XUwUxuTyceixWJ1Zy73/rWqdmHcI/fYcrHhiL3hkcqJrQ94CrP9nVcfzBJqaAW1JV4h+PBUksRthl5ukIWpB9aPfaDSAOP9v0TuvBU8W6Qa+G5rvw2W8FY/LQloZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368117; c=relaxed/simple;
	bh=PmwG4shIcnf5UENuE2G+mp68iq1yKL/zXf5/0+E+IVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKjhtiYRwpi/+qXIEhcmGYSnSVAmRrko0L89TIz2YlD8zbrywTnVD0RgghVifELohnq2wwh8V6u0fCzG4EiRExB6T3yCDTOWFkWIVluM0IfW+jDN7umjBq/Nqdh3A/gYKj/Xw3T/VPbMzu/wrR57Wg70Ua+j8mnMl/xbfOwE64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN3DFbFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8313DC433F1;
	Mon, 25 Mar 2024 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711368116;
	bh=PmwG4shIcnf5UENuE2G+mp68iq1yKL/zXf5/0+E+IVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qN3DFbFlPN49+7vVl+5PdlFU+NMHb7Rt+8v6HAb/Jk6z0zETG3vXmFcsmHVyP18wT
	 p/40KI77w1WlmBT47JTjOKPG3RRP8odhvRHi3li0fwtkxpv/xN7v32QDkYoJgI3HwR
	 I9WDbt48jPoIoc4sL37j4ioaQgydJTZLRdJ0SuBY76iqarvCZZiEn8etMPK7zV11z/
	 ut40aALYDsUPC73CXonaoLhCZsSEyus9dp6JsVAxqVqs4HMH1TkAdCOwqmJBKeTZMh
	 NYN5/L7YfnQ4/maq94Uhn9icVik/ww+Egz/b10FjEqkYS4BTRVG6sR33IGHJfr5yAx
	 rR2QDtRIM1xiw==
Date: Mon, 25 Mar 2024 13:01:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] ntfs3: serve as alias for the legacy ntfs driver
Message-ID: <20240325-waldhaus-fegten-59746baa161d@brauner>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-hinkriegen-zuziehen-d7e2c490427a@brauner>
 <ZgFNWPCYQC6xYOBX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgFNWPCYQC6xYOBX@hovoldconsulting.com>

On Mon, Mar 25, 2024 at 11:09:28AM +0100, Johan Hovold wrote:
> On Mon, Mar 25, 2024 at 09:34:36AM +0100, Christian Brauner wrote:
> > Johan Hovold reported that removing the legacy ntfs driver broke boot
> > for him since his fstab uses the legacy ntfs driver to access firmware
> > from the original Windows partition.
> > 
> > Use ntfs3 as an alias for legacy ntfs if CONFIG_NTFS_FS is selected.
> > This is similar to how ext3 is treated.
> > 
> > Fixes: 7ffa8f3d3023 ("fs: Remove NTFS classic")
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Link: https://lore.kernel.org/r/Zf2zPf5TO5oYt3I3@hovoldconsulting.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Hey,
> > 
> > This is so far compile tested. It would be great if someone could test
> > this. @Johan?
> 
> This seems to do the trick. Thanks for the quick fix.
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Do we want to do something about the fact that ntfs mounts may now
> become writable as well?

We can enforce that mounting as ntfs means that it's read-only unless rw
support is compiled in most likely. @Anton or other maintainers?

