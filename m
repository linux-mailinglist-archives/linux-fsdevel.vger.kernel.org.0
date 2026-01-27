Return-Path: <linux-fsdevel+bounces-75619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLsBJ3rSeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:58:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E399625B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5A7302352D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDAC35CB9B;
	Tue, 27 Jan 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOOj5m9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F6D35BDC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525870; cv=pass; b=GrY08h5DVNJhOfrgppaFxcACOaRPzRpwqLvCX9GnT+7m701KskaioDLcOXmV0B4QtqepZb8iMwZzXsl6XuA4SlqhlpNbHgtAH3odV1nPPbQY34bW18SZCwIzYUefjP92WFLiHQWpk4KCbYq5DtP8LSUvBcYXtD0AO+gY41QsUug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525870; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZcN0HiEqEr+Ky0csnf2Gfn9goMJqADCwPfIW58zTjcYRioph9eJ2kmQ2+KF+DsyKchM7EUu3ETqXcko4+A83Ft6LdnRQ+jSv9quLiSznM/dQ2aSfBzPEYGa7mfV1m0Jn/pMzLiFAxBUDL6RdViQ1ejGlDoo3soENIQoUoPgvDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOOj5m9R; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so8617472a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525867; cv=none;
        d=google.com; s=arc-20240605;
        b=gomQSVwFgA8VFoKidfLAqXu4R3gV2WAzGuSBIE9/8YPgPq4lhNDFmm7jVEgQcPHVFt
         MGHqFSTFjldWyRPhAXhTcs/DUhB0bMpkLC5yNaOy04YRvn6PXuSjnIpkdevg1cExuJrQ
         QHX5WgjgnuN7Zz0uHSCPZGSSdqtXdjByGWRLi3WtdtAYWeBYW0A0iL4qQX5MKrwkZq21
         13m8JUSP4B4OvikuKb9ru57/v4/YIuqYAz4wUcvwjQp3BWbCONS3LYi+LV3YNS2BwRy9
         D+vmESgMoEhMzhIrZpS5q1jrRfhEFA+HAmv68dA+q2KM1R6wFqNLAvNpBJGzkUAsFuKE
         NkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=lzheMxWeBzPLSvzEOdl9nKq7ufFeyuIgiXULtayaMes=;
        b=OBl3hYX0FeoFF+kvbRL/nVK5YOxYv2oN35UbVl+HdD5/O2Cn1RhR0zE8FRD3mwAmYP
         ifo/i3zaeq2gIehRcd/d0d9GfoNnjI6v0t87F/xFHgFHkE6dCDRqncFyWgNVL5Qd7Gs4
         ukg+p4PaRof3+0Zqm1vA/77mQ5iwYyCd8eN3She8VvjfG3uYk2NtaWDX6CdvLII8j9GO
         VIaRJAAVRK+X0G+NSDYfZIvomQSVxZCtgF/WbJ9dQyVqFXE63q0SCq0RFwp0o+zTybdB
         6Xuw0HKCzKO3cirvoL43mhOW5s+0GxY5Nu1A2HfBllr+1kACh6Knq6f9lPp/FdP0lHcg
         DB/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525867; x=1770130667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=fOOj5m9Rr2zn8jmGi3sCVz5AXd+WDsjyCI3+teIiZNkBnZ6Z3To04LLAcmzfCyYy6H
         y1nJfTdZjf8rSyCf5wlPwsZtmQMK+ORo1MbltCQm/Q909Es+0LZEJM3/dg8XR7UyScZj
         edjx2X51oOqyTPAP1oGPGo7hFU/pt+19e86F5D4fHqtP2tEqAO1gAZgYqEscUruc7EaD
         c6DHElCxSfTwNrNaJSsYQp712jykxScyTyQ+WRSsNr28FOfEEf9Qi75NoF0RfcPMDMXd
         Sz1x4UrNCB2tJjIsZfjApDzYYGgoetHaVScquFNH1YDAyXv5t5vC0Ad4jMfNU7H1ezcx
         tflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525867; x=1770130667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=g+286UZq1tDXU9Qe7xorb83qS8kI8Mav76ewo+xVCCQ6o+YCbuFGzNp0cCEZMSTJmq
         usg4fBkqKtP5Y43gmElreQNFkYG0E7vloXwKkdLQVZq6aZDlE+HDrQJCL5nws+yyYol8
         gnltNnOIfKMdfMVPHL/0DJ/SolanINh28V1ll9OK0+Ls0sVMl5DUVA4Cm5nUobQpL14J
         BY365qkQ1RDRmi4FvDUIpHpadA9X/tFYTiSBSe1BaLbgQw/BvSnZZ88dW5pwGrwaKbBQ
         1w8nA7w37yVElpaxOsT8rlFq6pX3fmPjLzheF2tSHZ/fNOhBN4JAKcmWXqv5mZTE89KA
         eYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWybF/zDKqWxZlG6jAw7AE0BYRV0akD8MIj1ij+vjWopHz8fXykxb2fWf+hvvu+g6/tSnpAlxqCCLSTERKk@vger.kernel.org
X-Gm-Message-State: AOJu0YxOX7pRgnJJF6htmEJ/IE1BAINjLAlgu3cdNPLKG4L2/ALwAgYU
	6fKRXNtSCtWAADiuECAW9ivRyrP3dkUrXnCyymPLjqYJ50DnnRRCCSgo+/NP3Ln4iRT6dSR1hMd
	BhxpYKjWzBNcaKJypKwowvvEA3dpTDQ==
X-Gm-Gg: AZuq6aJ8h+2YKNhAIE5FCu2kdi1ReD5jGES2/KALrG7nH/Sim6azAbqiw66NmeZsWNi
	q82TQ6ff68MEqjWnUjAqUvil7CKCLvt/99pQkXOD2jGRjrciuBgAJ/vs0C5dUlCnUN+RDjA6vHY
	iCZEkkT2ciDPlZGw9Ht2afk/jvulxjrh6LGyWZskeoLf3jxLN+QB9o6Wj8WBDSQ15MgUAGi5mEC
	LUH+DB8zAGjy9kxNZaNT7vvGMeSNouLK2QY1QG9z7z6N+ihp5eB05MLMvYtViYSo0OE+ETsNK6U
	LQnXrnKufa1REwWoAbx0gQgbZa3Wuej2ZDJZkhYTo7RkM4z8KsqENRMZIRHXElQjBlPw
X-Received: by 2002:a05:6402:3481:b0:653:9849:df10 with SMTP id
 4fb4d7f45d1cf-658a60a2a1fmr1194748a12.26.1769525867163; Tue, 27 Jan 2026
 06:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-7-hch@lst.de>
In-Reply-To: <20260121064339.206019-7-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:27:10 +0530
X-Gm-Features: AZwV_Qj4X0rX0yo1V91-mqj5DZP7DcX3ShOAwmDMBq59mWSXl3oyqbRMM9BDq0A
Message-ID: <CACzX3AuBQNjOtnmRFFXsyggUWqRB8eJrhpLwjUFzsLzVcKrSog@mail.gmail.com>
Subject: Re: [PATCH 06/15] block: add fs_bio_integrity helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75619-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 04E399625B
X-Rspamd-Action: no action

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

