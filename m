Return-Path: <linux-fsdevel+bounces-70915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 556C5CA9938
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 00:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86B83185761
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C522D9EED;
	Fri,  5 Dec 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WUINFPsX";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QE5KlkiY";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fqMJg5+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta45.messagelabs.com (mail1.bemta45.messagelabs.com [85.158.142.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288F3B8D67;
	Fri,  5 Dec 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.142.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975856; cv=none; b=qV+ohP8TuWle2aJAO8twFU9y/eMBhOSr5W1V7Z7bCgVvYIh33MpMPnRmD3Ux9P20ORzMbYB7IFKbKjaZ1U5Yvnc5FUu1fGlLIXIulA7DfQfT09suh11K+30shlNBqBG7z9XAqnDS75RCuHDUvuyBXdHni1YbWBA+w/fxUOPYnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975856; c=relaxed/simple;
	bh=6C6fC86OQWVle70CRS/xPm4uczU5DaR6lMAdQEoXrfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4kKJk+xL5JmRZrcxxOz82W2REffu2b7+wwafUhDhUxXRyrse9gtBhGsjrxP5sLmMt+UkyMUc0/Gs/O5PkVJkf12zQBsq5EnH3fNjRbUXE4nYjIB+EypYZiYSEGLz6AVbtcEU4SmhXXNUSxzYjYI5V7DplsnIC3yiepLmS4rdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WUINFPsX; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QE5KlkiY; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fqMJg5+G; arc=none smtp.client-ip=85.158.142.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1764975852; i=@fujitsu.com;
	bh=Y7fXjpD4VkGcCCMANUeO6niKVPw+9njd3zj/Dv483Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	b=WUINFPsXqv0GiAwot7aCkqM+sfA3L0pmWaPWYxVFqEobQtc4w1+8yFwSH7oMLBpkv
	 eeTUX3kymdFs9/JVJbhwTzCTmm+fYCkPZ8a8IRNt3qpexC/Xchf8oQRQAo32m5Vucy
	 0ZErMESnN/0SdivcIFlpOcnJ7uIQ5bp+GwVYhJmPgmPHI+w3UlabUdnj0xG157T8Fl
	 yoEYam/0sE5BmZ09vDI9aXqIiL3WygeGRYIkjsRq4AyBG1nnq1K2myb97W4KLZNMUw
	 chWPGU3Pyf+aJ2WwMJdBhlvjZHaadx5tlskTy775ACStUPZVFJdOnC5u8bt2MEbL6w
	 dJiY8s2Bb79xw==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfVAUZRzHeXb39hbimOWg3BhCuxlwZOYOkbG
  ezBiciWbJmYQ/yKJJWmC7u7o3d486GCoKLgGBSDmROzUMR3mNBDJieFOIE0LODB1RsWbgTA9I
  jbfjRWwPguy/7zOfz+/3fP/4Eaj0ZzyIYE1GltMxGhnug0XvJA7J76ZFqbeaiwg4MnoZh/PT9
  wH8+sQsAqe+X8ZhmeUygBeHP8dh7XAdgDmVDTh0NC3hsNP5JwZtZTkIPNRyFYU1J6/h0Frajk
  CHtR+Dbe19GPyt9RgOp4p6ADSfmAQwz2lBYLV7SQTz7mej0F7UhcDj0xYU3jpyGsC66YcovHn
  RIYI3SnoRuOgWZjt6fsdiQug5czFGm688wumfrCNiOrdnUkQ3VYXTlW33ELqxJh+nO4/Xiem7
  TeWA7nI9ArTF9hk9UNEjpqcaQ+hFWy+I90sSqXUpetN7ItWlU0WYYdrbNF41i2aDPKIAeBNSs
  hlQE5NJnoyRe6iC7hpRAfAR8jmMsrjdqOchJQ8gVO3MN2DNqq0tRNethdsWZNU6Cqgviqswj4
  WTEdT1w8dWJgLJZ6jihSbMI6FkO051WM+hHhBA7qPqbddFq2tDqdmOs4gnS8ho6mbuabEnU+R
  GylXatOJ4k8nUiL0QWS2+T+jX+q/vT/WVj618jAp+zg82dHU2jLo62IiWgADrE5r1Ca0CIDXg
  JZ7lPmI5+XZFCqdWqoxaRq1RMJlyRsGmc3oDK9fpOaMqUqFMNShYnlfwGdpUTZpCxxobgXBLP
  g/It1pAxVhuxAXwLIHInpbY4qPUUr8UfVqGiuFVyVy6huUvgGCCkFGSOykC8+dYJWt6X60RLn
  INU4SvLFByKUrAEt7AaHm1chX1gyji7O2udpR4eM9yHpViOr2ODdogGWAElfSoqnTd+qK1674
  CngsKkAAvLy+pr4HltGrj/7kLbCCALECyJ1XY4qvWGdf/cwlVEKFK+IFtnipG5j8UlI3Ub75j
  epz7zohmKjTVvqk8ays/F9ewY+/w5obuwKzE5UW/bZrXvkvYa/Pxa0RaEgpvLUewk2f+WpTPO
  jOwN3ZV4+N1Z2y7+9yyUdGo7/aQHPuN2tf7JyZm2lAvaZiDrOTze7cog6N/bd6Ub5c4B59aUk
  Zw+yeipMsx3Oj8DpHo1ZIj4g/fzHxlZ2Ts37uxk6HXNuJtxd8OzR3sjpB6xZ4vfzshTGn44I+
  wnH7q0+QvTcZS/4H9u553TufGYL0pLwQXfCV+N1AzlD8pHy/7JTZuPk7bOTbndmQedDUn6pcT
  H0xkLJxKUsbOvFz9SexMvG3sx/oXH7cOZo2YP97S7T8UEH20VYbxKiYyHOV45h8+FePqWAQAA
  A==
X-Env-Sender: tomasz.wolski@fujitsu.com
X-Msg-Ref: server-12.tower-838.messagelabs.com!1764975847!38940!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.120.0; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26844 invoked from network); 5 Dec 2025 23:04:08 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-12.tower-838.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Dec 2025 23:04:08 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 07284104798;
	Fri,  5 Dec 2025 23:04:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local 07284104798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1764975847;
	bh=Y7fXjpD4VkGcCCMANUeO6niKVPw+9njd3zj/Dv483Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QE5KlkiY44HYL3AI+5ggy8tJJo8l5Oiod4RyNXI82tloYIefX0tKFd8FP8yLKBzd9
	 OgjbglfldgF5m3E7P7weI+NE5QPwe+93TYZ85qxDITHiDHG/nFj6ccvtrjQJwtZi2l
	 pUnppbOseaJFZ/yXx4DTwb/xL8/G3KaIVd1skVEqs1XYa4pWf9rsjjxDUqxPy2WcAP
	 2oygyZZG9npafU3G+FBSZOEK79HbN2EG+xJy85bwx5lOYTa+iWR0Ck60UkgWtsNN5F
	 ZJuUQqDYGJ/21R/oZ1Xv8+LTgwegnsgAGFolfaz0gnTCd+cj9EjvizM8/2KX8lqYZm
	 s6R9SFNh9/mig==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id D92F81005E1;
	Fri,  5 Dec 2025 23:04:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local D92F81005E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1764975846;
	bh=Y7fXjpD4VkGcCCMANUeO6niKVPw+9njd3zj/Dv483Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqMJg5+GnlwcXge+7D6S4U3LOI3cvuY04MWDvJ9kOxLiL8+umshJPnxtzh+TaL8Uo
	 QXlsldAeU2f64P9iQjDj9RCu7OcO+edyWaLb009/ls+8WSmuTzc8a30ne6z8NfSiPE
	 9f2kTZfUUKUmwgwx+KeirRfHZOPGFhq1voLf9nb8ODHQP0RadyWANjn+q0XMJBWhJl
	 GdS9Wz8IjbNh298I/HHJKPGDmCEyJQoNmEvaULLDYG5+pCQ/SCgTPfrnK5T0tb+bYP
	 tGBNq0BUfEFlKgbVQJFi7HjBwxSLktbrbFkrSiX6Ty0zNjfpuHS5fbjlEK537v1cCI
	 x1un6ooWVDtvA==
Received: from localhost.BIOS.GDCv6 (unknown [10.172.196.36])
	by ubuntudhcp (Postfix) with ESMTP id A113322059C;
	Fri,  5 Dec 2025 23:04:26 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: y-goto@fujitsu.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	gregkh@linuxfoundation.org,
	huang.ying.caritas@gmail.com,
	ira.weiny@intel.com,
	jack@suse.cz,
	jeff.johnson@oss.qualcomm.com,
	jonathan.cameron@huawei.com,
	len.brown@intel.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lizhijian@fujitsu.com,
	ming.li@zohomail.com,
	nathan.fontenot@amd.com,
	nvdimm@lists.linux.dev,
	pavel@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	rrichter@amd.com,
	terry.bowman@amd.com,
	tomasz.wolski@fujitsu.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v4 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Sat,  6 Dec 2025 00:04:35 +0100
Message-ID: <20251205230445.16100-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <OS9PR01MB124214C25B1A4A4FA1075CADA90A7A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
References: <OS9PR01MB124214C25B1A4A4FA1075CADA90A7A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hello Dan & Gotou-san,

Many thanks for your remarks for the test cases
For the qemu tests I used modified qemu and sebios, therefore some 'strange' cases
are only testable on virtual setups - thanks for making it clear which configurations
are supported in real life

>> 
>> [4] Physical machine: 2 CFMWS + Host-bridge + 2 CXL devices
>> 
>> kernel: BIOS-e820: [mem 0x0000002070000000-0x000000a06fffffff] soft 
>> reserved
>> 
>> 2070000000-606fffffff : CXL Window 0
>>   2070000000-606fffffff : region0
>>     2070000000-606fffffff : dax0.0
>>       2070000000-606fffffff : System RAM (kmem) 6070000000-a06fffffff 
>> : CXL Window 1
>>   6070000000-a06fffffff : region1
>>     6070000000-a06fffffff : dax1.0
>>       6070000000-a06fffffff : System RAM (kmem)
>
>Ok, so a real world maching that creates a merged 0x0000002070000000-0x000000a06fffffff range. Can you confirm that the SRAT has separate entries for those ranges? >Otherwise, need to rethink how to keep this fallback algorithm simple and predictable.

I looked into the syslogs and I see the SRAT has separate entries:

[    0.005128] [      T0] ACPI: SRAT: Node 2 PXM 2 [mem 0x2070000000-0x606fffffff] hotplug
[    0.005129] [      T0] ACPI: SRAT: Node 2 PXM 2 [mem 0x6070000000-0xa06fffffff] hotplug


